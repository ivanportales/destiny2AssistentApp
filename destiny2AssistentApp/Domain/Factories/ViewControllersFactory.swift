//
//  ViewControllersFactory.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation
import SafariServices

class ViewControllersFactory {
    private let authService: AuthenticationService
    private let service: ServiceProtocol
    
    init(authService: AuthenticationService,
         service: ServiceProtocol) {
        self.authService = authService
        self.service = service
    }
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(service: authService)
    }
    
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController()
    }
    
    func makeWebView(with url: URL) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
}
