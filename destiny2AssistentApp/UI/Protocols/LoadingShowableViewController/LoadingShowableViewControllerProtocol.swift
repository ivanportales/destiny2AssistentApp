//
//  LoadingShowableViewController.swift
//  eveEchoesCompanionApp
//
//  Created by Gonzalo Ivan Santos Portales on 11/07/22.
//

import UIKit

public protocol LoadingShowableViewControllerProtocol: UIViewController {
    var loadingView: UIActivityIndicatorView? { get set }
    
    func setupLoadingView()
    func disableLoadingView()
}

extension LoadingShowableViewControllerProtocol {
    
    public func disableLoadingView() {
        guard let _ = loadingView else { return }
        loadingView?.stopAnimating()
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    public func setupLoadingView() {
        if let _ = loadingView {
            return
        }
        let loadingView = makeLoadingView()
        loadingView.startAnimating()
        view.addSubview(loadingView)
        loadingView.constraintViewToCenterOfSuperview()
        self.loadingView = loadingView
    }
    
    private func makeLoadingView() -> UIActivityIndicatorView {
        let loadingView = UIActivityIndicatorView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.style = .large
        
        return loadingView
    }
}
