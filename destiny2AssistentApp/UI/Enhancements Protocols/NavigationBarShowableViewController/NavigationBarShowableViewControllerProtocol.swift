//
//  NavigationBarShowableViewController.swift
//  eveEchoesCompanionApp
//
//  Created by Gonzalo Ivan Santos Portales on 11/07/22.
//

import UIKit

public protocol NavigationBarShowableViewControllerProtocol: UIViewController {
    func setupNavigationBar(withLargeTitle showLargeTitle: Bool)
    func setupNavigationBarItemOn(positon: NavigationItemPosition,
                                  withIcon icon: UIImage?,
                                  color: UIColor,
                                  and completion: @escaping (ClosureBasedUIButton) -> Void)
}

extension NavigationBarShowableViewControllerProtocol {
    
    public func setupNavigationBar(withLargeTitle showLargeTitle: Bool = false) {
        navigationItem.largeTitleDisplayMode = showLargeTitle ? .always : .never
    }
    
    public func setupNavigationBarItemOn(positon: NavigationItemPosition,
                                         withIcon icon: UIImage?,
                                         color: UIColor,
                                         and completion: @escaping (ClosureBasedUIButton) -> Void) {
        let button = ClosureBasedUIButton()
        button.setImage(icon ?? .actions, for: .normal)
        button.imageView?.tintColor = color
        button.touchDownCompletion = completion
        
        switch positon {
        case .left:
            navigationItem.setLeftBarButton(.init(customView: button), animated: false)
        case .right:
            navigationItem.setRightBarButton(.init(customView: button), animated: false)
        }
    }
}
