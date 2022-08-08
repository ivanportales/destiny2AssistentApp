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
    private let service: Service
    
    init(authService: AuthenticationService,
         service: Service) {
        self.authService = authService
        self.service = service
    }
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(service: authService)
    }
    
    func makeHomeViewController(token: TokenResponse) -> HomeViewController {
        let destinyService = DestinyService(tokenResponse: token,
                                            service: service,
                                            requestFactory: RequestFactory(constants: Destiny2APIConstants()))
        return HomeViewController(service: destinyService)
    }
    
    func makeWebView(with url: URL) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
}
