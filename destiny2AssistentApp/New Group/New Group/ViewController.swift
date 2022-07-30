//
//  ViewController.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 23/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoView()
    }

    private func setuoView() {
        view.backgroundColor = .red
    }
}
