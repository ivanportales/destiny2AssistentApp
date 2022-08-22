//
//  HomeViewModel.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 08/08/22.
//

import Foundation

enum HomeState {
    case loading
    case content
    case error(message: String)
}

class HomeViewModel {
    
    private let service: HomeServiceProtocol
    private(set) var cellsViewModels: [BadgeInfoViewModel] = []
    private(set) var state: HomeState = .loading {
        didSet {
            stateChangedCallback?(state)
        }
    }
    var model = HomeModel.emptyModel
    
    var screenTitle: String {
        return model.user.displayName
    }
    
    var stateChangedCallback: ((HomeState) -> Void)?
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    func getUserProfileInfo() {
        state = .loading
        service.getUserProfileInfo{ [weak self] result in
            switch result {
            case .success(let model):
                self?.model = model
                self?.cellsViewModels = model.destinyAccounts.compactMap({ [weak self] account in
                    if let self = self {
                        return BadgeInfoViewModel(model: account, service: self.service)
                    }
                    return nil
                })
                self?.state = .content
            case .failure(let error):
                self?.state = .error(message: error.localizedDescription)
            }
        }
    }
}
