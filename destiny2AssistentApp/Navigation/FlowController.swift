//
//  FlowController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import UIKit

class FlowController {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllersFactory
    private let authService: AuthenticationService
    
    init(navigationController: UINavigationController,
         factory: ViewControllersFactory,
         authService: AuthenticationService) {
        self.navigationController = navigationController
        self.factory = factory
        self.authService = authService
        authService.requestedAuthorizationCallback = { url in
            DispatchQueue.main.async {
                let webViewController = factory.makeWebView(with: url)
                navigationController.present(webViewController, animated: true, completion: nil)
            }
        }
    }
    
    func start() {
        let viewController = factory.makeLoginViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // aqui vamo dar um handle nos deeplinks
    func handle(openURLContext: UIOpenURLContext) {
        authService.handleURLFromDeepLink(openURLContext.url) { result in
            switch result {
            case .success():
                print("indo pra tela de Home")
            case .failure(let error):
                print(error)
            }
        }
    }
}

//extension FlowController: LoginViewControllerDelegate {
//    func openLoginWebView(_ viewController: LoginViewController, with url: URL) {
//
//    }
//}
