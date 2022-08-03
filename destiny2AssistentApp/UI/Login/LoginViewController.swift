//
//  LoginViewController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation
import UIKit

protocol LoginServiceProtocol {
    func requestLogin(completion: @escaping (Result<Void, Error>) -> Void)
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
            
    private let service: LoginServiceProtocol

    init(service: LoginServiceProtocol) {
        self.service = service
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
        service.requestLogin { result in
            switch result {
            case .success():
                print("FOI CARALHO")
            case .failure(let error):
                print(error)
            }
        }
    }
}
