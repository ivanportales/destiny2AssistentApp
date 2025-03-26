//
//  ContentView.swift
//  destiny2AssistentAppMac
//
//  Created by Gonzalo Ivan Santos Portales on 26/03/25.
//

import Combine
import SwiftUI

protocol AuthenticationManagerProtocol {
    var isLoggedIn: Bool { get }
    
    func requestLogin(withUser user: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class AuthenticationManager: ObservableObject, AuthenticationManagerProtocol {
    
    private let authenticationService: AuthenticationServiceProtocol
    @Published var isLoggedIn: Bool = false

    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
    
    func requestLogin(withUser user: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        authenticationService.requestAuthentication { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.isLoggedIn = true
                    completion(.success(success))
                case .failure(let error):
                    self?.isLoggedIn = false
                    completion(.failure(error))
                }
            }
        }
    }
}

final class AppFactory {
    static let shared: AppFactory = .init()
    
    private init() {}
    
    func buildAuthenticationManager() -> AuthenticationManager {
        let service = Service(httpClient: URLSession.shared,
                              decoder: DataDecoder())
        
        let authService = AuthenticationService(service: service,
                                                requestFactory: RequestFactory(constants: GitHubAPIConstants()))
        
        return AuthenticationManager(authenticationService: authService)
    }
}

struct ContentView: View {
    @StateObject private var auth: AuthenticationManager = AppFactory.shared.buildAuthenticationManager()
    
    var body: some View {
        if auth.isLoggedIn {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("LOGADO")
            }
            .padding()
        } else {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("NAO LOGADO")
            }
            .padding()
            Button(action: {
                auth.requestLogin(withUser: "") { result in
                    
                }
            }) {
                Text("Login")
            }
        }
    }
}

#Preview {
    ContentView()
}
