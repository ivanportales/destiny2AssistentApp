//
//  FlowController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import UIKit
import SafariServices

class FlowController {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllersFactory
    
    init(navigationController: UINavigationController,
         factory: ViewControllersFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let viewController = factory.makeLoginViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension FlowController: LoginViewControllerDelegate {
    func openLoginWebView(_ viewController: LoginViewController, with url: URL) {
        let webViewController = SFSafariViewController(url: url)
        viewController.present(webViewController, animated: true, completion: nil)
    }
}

class ViewControllersFactory {

    
    func makeLoginViewController() -> LoginViewController {
        let requestFactory: RequestFactoryProtocol = RequestFactory(constants: AuthenticationConstants())
        return LoginViewController(requestFactory: requestFactory)
    }
    
    func makeWebView(with url: URL) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
}

class AppMainFactory {
    
    private let navigationController: UINavigationController = UINavigationController()
    
    func makeMainAppWindowWith(appScene: UIWindowScene) -> UIWindow? {
        let window = UIWindow(windowScene: appScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return window
    }
    
    func makeAppFlowController() -> FlowController {
        let viewControllerfactory = ViewControllersFactory()
        
        return FlowController(navigationController: navigationController,
                              factory: viewControllerfactory)
    }
}
