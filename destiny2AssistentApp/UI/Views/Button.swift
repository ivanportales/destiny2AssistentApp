//
//  Button.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 05/08/22.
//

import UIKit

public class Button: UIView {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .clear
        
        return titleLabel
    }()
    
    private let title: String
    private let touchDownCompletion: ((Button) -> Void)
    
    init(title: String,
         touchDownCompletion: @escaping ((Button) -> Void)) {
        self.title = title
        self.touchDownCompletion = touchDownCompletion
        super.init(frame: .zero)
        setupView()
        setupViewsHierarchy()
        setupViewsConstraints()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray.withAlphaComponent(0.4)
        setupBorder()
    }
    
    private func setupViewsHierarchy() {
        addSubview(titleLabel)
    }
    
    private func setupViewsConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupGestures() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(gestureAction))
        
        addGestureRecognizer(gesture)
    }
    
    private func setupBorder() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.cgColor
    }
    
    @objc private func gestureAction() {
        touchDownCompletion(self)
    }
}
