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
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.constraintView(height: 80, andWidth: 80)
        imageView.isHidden = true
        
        return imageView
    }()
    
    lazy var informationStackView: UIStackView = {
        let informationStackView = UIView.makeUIStackWith(distribution: .fillEqually,
                                                          alignment: .leading,
                                                          spacing: 5)
        return informationStackView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UIView.makeUILabelWith(text: "")
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        return titleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UIView.makeUILabelWith(text: "")
        subtitleLabel.isHidden = true
        subtitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return subtitleLabel
    }()
    
    lazy var trailingLabel: UILabel = {
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
        clearView()
        if let backgorundImagePath = model.backgroundImagePath {
            setupImage(fromPath: backgorundImagePath, to: backgroundImageView)
        }
        
        setupImage(fromPath: model.iconImagePath, to: iconImageView)
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
        informationStackView.addArrangedSubview(titleLabel)
        informationStackView.addArrangedSubview(subtitleLabel)
        containerStackView.addArrangedSubview(iconImageView)
        containerStackView.addArrangedSubview(informationStackView)
        containerStackView.addArrangedSubview(trailingLabel)

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
        titleLabel.text = model.title
        if let subtitle = model.subtitle {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = false
        }
    }
    
    private func setupTrailing(info: String) {
        trailingLabel.text = info
        trailingLabel.isHidden = false
    }
    
    private func clearView() {
        iconImageView.image = nil
        iconImageView.isHidden = true
        
        titleLabel.text = ""
        subtitleLabel.text = ""
        subtitleLabel.isHidden = true
        
        trailingLabel.text = ""
        trailingLabel.isHidden = true
    }
}

fileprivate class TitleAndLabelView: UIView {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UIView.makeUILabelWith(text: "")
        return titleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UIView.makeUILabelWith(text: "")
        return subtitleLabel
    }()
    
    let title: String
    let subtitle: String?
    
    init(title: String,
         subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
        super.init(frame: .zero)
        setupView()
        setupViewsHierarchy()
        setupViewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViewsHierarchy() {
        addSubview(titleLabel)
        if let _ = subtitle {
            addSubview(subtitleLabel)
        }
    }
    
    private func setupViewsConstraints() {
        guard let _ = subtitle else {
            setupViewConstraintsWithSubtitle()
            return
        }
        setupViewConstraintsWithoutSubtitle()
    }
    
    private func setupViewConstraintsWithSubtitle() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupViewConstraintsWithoutSubtitle() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
