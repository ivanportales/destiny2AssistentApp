//
//  UIViewController+Extensions.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 09/08/22.
//

import UIKit

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
