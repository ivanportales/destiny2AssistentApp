//
//  ViewController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 23/07/22.
//

import UIKit

protocol HomeServiceProtocol {
    func getUserProfileInfo(completion: @escaping (Result<HomeModel, Error>) -> Void)
}

class HomeViewController: UIViewController,
                          LoadingShowableViewControllerProtocol,
                          NavigationBarShowableViewControllerProtocol {
    var loadingView: UIActivityIndicatorView?
    
    lazy var requestButton: Button = {
        let requestButton = Button(title: "Request") { [weak self] _ in
            self?.viewModel.getUserProfileInfo()
        }
        
        return requestButton
    }()
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
        viewModel.getUserProfileInfo()
    }
    
    private func setupNavigationBarTitle() {
        title = viewModel.screenTitle
        setupNavigationBar(withLargeTitle: true)
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
    
    private func setupBindings() {
        viewModel.stateChangedCallback = { [weak self] state in
            switch state {
            case .loading:
                self?.handleLoading()
            case .content:
                self?.handleContent()
            case .error(message: let message):
                self?.handleError(withMessage: message)
            }
        }
    }
    
    private func handleLoading() {
        setupLoadingView()
    }
    
    private func handleContent() {
        if let _ = loadingView {
            disableLoadingView()
        }
        
    }
    
    private func handleError(withMessage message: String) {
        let alertButton = AlertButton(title: "Reload") { [weak self] in
            self?.viewModel.getUserProfileInfo()
        }
        presentAlert(with: "Error", andMessage: message, button: alertButton)
    }
}

struct AlertButton {
    let title: String
    let action: () -> Void
}

extension UIViewController {
    func presentAlert(with title: String, andMessage message: String, button: AlertButton? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        setupAction(withTitle: "Ok", style: .destructive, handler: nil, for: alertViewController)
        if let button = button {
            setupAction(withTitle: button.title, style: .destructive, handler: button.action, for: alertViewController)
        }
        present(alertViewController, animated: true, completion: nil)
    }
    
    private func setupAction(withTitle title: String?,
                             style: UIAlertAction.Style,
                             handler: (() -> Void)? = nil,
                             for alertViewController: UIAlertController) {
        var handlerCallback: ((UIAlertAction) -> Void)?
        if let handler = handler {
            handlerCallback = { _ in
                handler()
            }
        }
        
        let action = UIAlertAction(title: title, style: style, handler: handlerCallback)
        alertViewController.addAction(action)
    }
}
