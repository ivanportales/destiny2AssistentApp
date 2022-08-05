//
//  UIView+Entensions.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 05/08/22.
//

import UIKit

// MARK: - Static Functions

extension UIView {
    static func makeUILabelWith(text: String,
                                font: UIFont? = .systemFont(ofSize: 15), // botar a nova font
                                color: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font
        label.textColor = color
        
        return label
    }
    
    static func makeUIStackWith(axis: NSLayoutConstraint.Axis = .vertical,
                                distribution: UIStackView.Distribution = .fill,
                                alignment: UIStackView.Alignment = .fill,
                                spacing: CGFloat = 5) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = spacing
        stack.alignment = alignment
        stack.distribution = distribution
        stack.axis = axis
        
        return stack
    }
    
    static func makeUIButtonWith(icon: UIImage?,
                                 withColor color: UIColor = .white,
                                 andCompletion completion: ((UIButton) -> Void)?) -> UIButton {
        let button = ClosureBasedUIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(icon, for: .normal)
        button.tintColor = color
        button.touchDownCompletion = completion
        
        return button
    }
}

// MARK: - Instance Functions

extension UIView {
    func constraintViewToSuperview() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    func constraintViewToCenterOfSuperview() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
            leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
            trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor),
            bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor),
            
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ])
    }
    
    func constraintView(height: CGFloat, andWidth width: CGFloat) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: width),
        ])
    }
}
