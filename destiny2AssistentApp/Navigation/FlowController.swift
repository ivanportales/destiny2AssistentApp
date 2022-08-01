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
    
    func handleAuthenticationFlowWith(code: String, andState state: String) {
        
    }
}

extension FlowController: LoginViewControllerDelegate {
    func openLoginWebView(_ viewController: LoginViewController, with url: URL) {
        let webViewController = factory.makeWebView(with: url)
        viewController.present(webViewController, animated: true, completion: nil)
    }
}
