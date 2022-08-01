//
//  LoginViewController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation
import UIKit

protocol LoginServiceProtocol {
    func requestLogin()
}

protocol LoginViewControllerDelegate: AnyObject {
    func openLoginWebView(_ viewController: LoginViewController, with url: URL)
}

class LoginViewController: UIViewController {
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.red, for: .normal)
        loginButton.addTarget(self, action: #selector(touchLoginButton), for: .touchUpInside)
        
        return loginButton
    }()
    
    //private let loginService: LoginServiceProtocol
    weak var delegate: LoginViewControllerDelegate?
    
    private let requestFactory: RequestFactoryProtocol
    
//    init(loginService: LoginServiceProtocol) {
//        self.loginService = loginService
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(requestFactory: RequestFactoryProtocol) {
        self.requestFactory = requestFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewsHierarchy()
        setupViewsConstraints()
    }

    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupViewsHierarchy() {
        view.addSubview(loginButton)
    }
    
    private func setupViewsConstraints() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func touchLoginButton() {
        //loginService.requestLogin()
        do {
            let state = UUID().uuidString
            guard let url = try requestFactory.make(request: AuthenticationRequest(stateCallbackUniqueId: state)).url else {
                return
            }
            delegate?.openLoginWebView(self, with: url)
        } catch {
            print(error)
        }
    }
}
