//
//  ViewController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 23/07/22.
//

import UIKit

protocol HomeServiceProtocol {
    func getUserProfileInfo(completion: @escaping (Result<HomeServiceResponse, Error>) -> Void)
}

class HomeViewController: UIViewController {
    
    lazy var requestButton: Button = {
        let requestButton = Button(title: "Request") { [weak self] _ in
            self?.service.getUserProfileInfo { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        print(model)
                    case .failure(let error):
                        print(error)
                        self?.presentAlert(with: "Error", andMessage: error.localizedDescription)
                    }
                }
            }
        }
        
        return requestButton
    }()
    
    private let service: HomeServiceProtocol
    
    init(service: HomeServiceProtocol) {
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
        service.getUserProfileInfo { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stringData):
                    print(stringData)
                case .failure(let error):
                    print(error)
                    self?.presentAlert(with: "Error", andMessage: error.localizedDescription)
                }
            }
        }
    }

    private func setupView() {
        view.backgroundColor = .red
    }
    
    private func setupViewsHierarchy() {
        view.addSubview(requestButton)
    }
    
    private func setupViewsConstraints() {
        NSLayoutConstraint.activate([
            requestButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            requestButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            requestButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
}

extension UIViewController {
    func presentAlert(with title: String, andMessage message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }
}
