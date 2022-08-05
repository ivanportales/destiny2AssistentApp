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
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .loginWallpaper
        //imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var loginButton: Button = {
        let loginButton = Button(title: "Login") { [weak self] _ in
            self?.service.requestLogin { result in
                switch result {
                case .success():
                    print("FOI CARALHO")
                case .failure(let error):
                    print(error)
                }
            }
        }
        
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
        view.addSubview(imageView)
        view.addSubview(loginButton)
    }
    
    private func setupViewsConstraints() {
        imageView.constraintViewToSuperview()
        
        NSLayoutConstraint.activate([
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)

        ])
    }
}
