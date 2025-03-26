//
//  FlowController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import UIKit
import AuthenticationServices

class MockedHomeService: HomeServiceProtocol {
    
    let service = Service(httpClient: URLSession.shared, decoder: DataDecoder())
    
    func getImageData(from path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let request: Request = .getImage(path: path)
            let urlRequest = try RequestFactory(constants: Destiny2APIConstants()).make(request: request)
            service.send(request: urlRequest, completion: completion)
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getUserProfileInfo(completion: @escaping (Result<HomeModel, Error>) -> Void) {
        completion(.success(.init(destinyAccounts: [.init(id: "", displayName: "Kvothe Bloodless", iconPath: "/img/theme/bungienet/icons/steamLogo.png", accountType: .steam)], user: .init(membershipId: "", displayName: "Kvotinho", lastUpdate: "", userTitleDisplay: ""))))
    }
}

final class FlowController: NSObject {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllersFactory
    private let authService: AuthenticationServiceProtocol
    private let login: Login
    
    init(navigationController: UINavigationController,
         factory: ViewControllersFactory,
         authService: AuthenticationServiceProtocol) {
        self.navigationController = navigationController
        self.factory = factory
        self.authService = authService
        let login = Login(authService: authService)
        self.login = login
        authService.requestedAuthorizationCallback = { url in
            DispatchQueue.main.async {
                login.signIn(withUrl: url)
//                let webViewController = factory.makeWebView(with: url)
//                navigationController.pushViewController(webViewController, animated: true)
            }
        }
    }
    
    func start() {
        let viewController = factory.makeLoginViewController()
        navigationController.pushViewController(viewController, animated: false)
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

final class Login: NSObject, ASWebAuthenticationPresentationContextProviding {
    
    private let authService: AuthenticationServiceProtocol
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn(withUrl url: URL) {
        let authSession = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: "destinyapp") { (url, error) in
                print(url)
                print(error)
                if let url {
                    self.authService.handleURLFromDeepLink(url) { [weak self] result in
                        DispatchQueue.main.async {
                            print("Result: \(result)")
                        }
                    }
                }
                
        }
        authSession.presentationContextProvider = self
        authSession.prefersEphemeralWebBrowserSession = true
        authSession.start()
    }
}
