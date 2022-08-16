//
//  BadgeInfoView.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 15/08/22.
//

import UIKit

protocol BadgeInfoModel {
    var backgroundImagePath: String? { get }
    var iconImagePath: String { get }
    var title: String { get }
    var subtitle: String? { get }
    var trailingInfo: String? { get }
}

class BadgeInfoView: UIView {
    
    lazy var backgroundImageView: UIImageView = {
        let backgroundView = UIImageView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.isHidden = true
        
        return backgroundView
    }()
    
    lazy var containerStackView: UIStackView = {
        let containerStackView = UIView.makeUIStackWith(axis: .horizontal,
                                                        distribution: .fillProportionally,
                                                        spacing: 10)
        return containerStackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.constraintView(height: 80, andWidth: 80)
        imageView.isHidden = true
        
        return imageView
    }()
    
    lazy var informationStackView: UIStackView = {
        let informationStackView = UIView.makeUIStackWith(distribution: .fillProportionally,
                                                          alignment: .leading,
                                                          spacing: 10)
        return informationStackView
    }()
    
    lazy var trailingInformationView: UILabel = {
        let trailingInformationView = UIView.makeUILabelWith(text: "")
        trailingInformationView.isHidden = true
        
        return trailingInformationView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupViewHierarchy()
        setupViewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view does not support Storyboard!")
    }
    
    func set(model: BadgeInfoModel) {
        if let backgorundImagePath = model.backgroundImagePath {
            setupImage(fromPath: backgorundImagePath, to: backgroundImageView)
        }
        
        setupImage(fromPath: model.iconImagePath, to: imageView)
        setupInformationStackView(withModel: model)
        
        if let info = model.trailingInfo {
            setupTrailing(info: info)
        }
    }
        
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    private func setupViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(imageView)
        containerStackView.addArrangedSubview(informationStackView)
        containerStackView.addArrangedSubview(trailingInformationView)

    }
    
    private func setupViewsConstraints() {
        backgroundImageView.constraintViewToSuperview()
        containerStackView.constraintViewToSuperview(top: 10,
                                                     leading: 10,
                                                     trailing: -10,
                                                     bottom: -10)
    }
    
    private func setupImage(fromPath imagePath: String, to imageView: UIImageView) {
        imageView.image = UIImage(named: imagePath)
        imageView.isHidden = false
    }
    
    private func setupInformationStackView(withModel model: BadgeInfoModel) {
        informationStackView.addArrangedSubview(UIView.makeUILabelWith(text: model.title))
        if let subtitle = model.subtitle {
            informationStackView.addArrangedSubview(UIView.makeUILabelWith(text: subtitle))
        }
    }
    
    private func setupTrailing(info: String) {
        trailingInformationView.text = info
        trailingInformationView.isHidden = false
    }
}
