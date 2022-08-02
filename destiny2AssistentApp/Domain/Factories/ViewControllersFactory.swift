//
//  ViewControllersFactory.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation
import SafariServices

class ViewControllersFactory {
    let authService: AuthService
    let service: ServiceProtocol
    
    init(authService: AuthService,
         service: ServiceProtocol) {
        self.authService = authService
        self.service = service
    }
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(service: authService)
    }
    
    func makeWebView(with url: URL) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
}
