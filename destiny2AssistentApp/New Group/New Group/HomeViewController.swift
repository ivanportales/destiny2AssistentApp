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
    
    lazy var accountsTableView: UITableView = {
        let accountsTableView = UITableView()
        accountsTableView.translatesAutoresizingMaskIntoConstraints = false
        accountsTableView.register(DestinyAccountTableViewCell.self,
                                   forCellReuseIdentifier: DestinyAccountTableViewCell.cellIdentifier)
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        
        return accountsTableView
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
        setupNavigationBarTitle()
        setupView()
        setupViewsHierarchy()
        setupViewsConstraints()
        setupBindings()
        viewModel.getUserProfileInfo()
    }
    
    private func setupNavigationBarTitle() {
        title = viewModel.screenTitle
        setupNavigationBar(withLargeTitle: true)
    }

    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupViewsHierarchy() {
        view.addSubview(accountsTableView)
        view.addSubview(requestButton)
    }
    
    private func setupViewsConstraints() {
        accountsTableView.constraintViewToSuperview()
        
        NSLayoutConstraint.activate([
            requestButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            requestButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            requestButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    private func setupBindings() {
        viewModel.stateChangedCallback = { [weak self] state in
            DispatchQueue.main.async {
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
    }
    
    private func handleLoading() {
        setupLoadingView()
    }
    
    private func handleContent() {
        if let _ = loadingView {
            disableLoadingView()
        }
        title = viewModel.screenTitle
        accountsTableView.reloadData()
    }
    
    private func handleError(withMessage message: String) {
        let alertButton = AlertButton(title: "Reload") { [weak self] in
            self?.viewModel.getUserProfileInfo()
        }
        presentAlert(with: "Error", andMessage: message, button: alertButton)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.destinyAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DestinyAccountTableViewCell.cellIdentifier,
                                                       for: indexPath) as? DestinyAccountTableViewCell else {
            return UITableViewCell()
        }
        
        cell.set(account: viewModel.model.destinyAccounts[indexPath.item])
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {}
