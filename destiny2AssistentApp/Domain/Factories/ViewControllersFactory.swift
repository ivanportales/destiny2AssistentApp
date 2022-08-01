//
//  ViewControllersFactory.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation
import SafariServices

class ViewControllersFactory {

    func makeLoginViewController() -> LoginViewController {
        let requestFactory: RequestFactoryProtocol = RequestFactory(constants: AuthenticationConstants())
        return LoginViewController(requestFactory: requestFactory)
    }
    
    func makeWebView(with url: URL) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
}
