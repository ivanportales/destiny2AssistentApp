//
//  FlowController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import UIKit

class MockedHomeService: HomeServiceProtocol {
    func getUserProfileInfo(completion: @escaping (Result<HomeModel, Error>) -> Void) {
        completion(.success(.init(destinyAccounts: [.init(id: "", displayName: "Kvothe Bloodless", iconPath: "steamLogo", accountType: .steam)], user: .init(membershipId: "", displayName: "Kvotinho", lastUpdate: "", userTitleDisplay: ""))))
    }
}

class FlowController {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllersFactory
    private let authService: AuthenticationServiceProtocol
    
    init(navigationController: UINavigationController,
         factory: ViewControllersFactory,
         authService: AuthenticationServiceProtocol) {
        self.navigationController = navigationController
        self.factory = factory
        self.authService = authService
        authService.requestedAuthorizationCallback = { url in
            DispatchQueue.main.async {
                let webViewController = factory.makeWebView(with: url)
                navigationController.pushViewController(webViewController, animated: true)
            }
        }
    }
    
    func start() {
        //let viewController = factory.makeLoginViewController()
        navigationController.pushViewController(HomeViewController(viewModel: .init(service: MockedHomeService())), animated: false)
    }
    
    func showHomeScreen(token: TokenResponse) {
        let viewController = factory.makeHomeViewController(token: token)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func showErrorScreen(with error: Error) {}
    
    // aqui vamo dar um handle nos deeplinks
    func handle(openURLContext: UIOpenURLContext) {
        authService.handleURLFromDeepLink(openURLContext.url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self?.pop()
                    self?.showHomeScreen(token: token)
                case .failure(let error):
                    self?.showErrorScreen(with: error)
                }
            }
        }
    }
}
