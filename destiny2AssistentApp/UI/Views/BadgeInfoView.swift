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

class BadgeInfoViewModel {

    let model: BadgeInfoModel
    let service: ImageService
    
    init(model: BadgeInfoModel,
         service: ImageService) {
        self.model = model
        self.service = service
    }
    
    func getImageData(completion: @escaping (Result<Data, Error>) -> Void) {
        service.getImageData(from: model.iconImagePath, completion: completion)
    }
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
                                                        distribution: .fill,
                                                        alignment: .top,
                                                        spacing: 10)
        containerStackView.backgroundColor = .clear
        
        return containerStackView
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.constraintView(height: 60, andWidth: 60)
        
        return imageView
    }()
    
    lazy var titleAndSubtitleView: TitleAndLabelView = {
        let titleAndSubtitleView = TitleAndLabelView()
        return titleAndSubtitleView
    }()
    
    lazy var trailingLabel: UILabel = {
        let trailingInformationView = UIView.makeUILabelWith(text: "")
        trailingInformationView.isHidden = true
        trailingInformationView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return trailingInformationView
    }()
    
    var viewModel: BadgeInfoViewModel?
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupViewHierarchy()
        setupViewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view does not support Storyboard!")
    }
    
    func set(viewModel: BadgeInfoViewModel) {
        clearView()
        self.viewModel = viewModel
        if let backgorundImagePath = viewModel.model.backgroundImagePath {
            setupImage(fromPath: backgorundImagePath, to: backgroundImageView)
        }
        
        setupImage(fromPath: viewModel.model.iconImagePath, to: iconImageView)
        setupInformationStackView(withModel: viewModel.model)
        
        if let info = viewModel.model.trailingInfo {
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
        containerStackView.addArrangedSubview(iconImageView)
        containerStackView.addArrangedSubview(titleAndSubtitleView)
        containerStackView.addArrangedSubview(trailingLabel)

    }
    
    private func setupViewsConstraints() {
        backgroundImageView.constraintViewToSuperview()
        containerStackView.constraintViewToSuperview(top: 15,
                                                     leading: 15,
                                                     trailing: -15,
                                                     bottom: -15)
    }
    
    private func setupImage(fromPath imagePath: String, to imageView: UIImageView) {
        viewModel?.getImageData(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    imageView.image = UIImage(data: imageData)
                    imageView.isHidden = false
                case .failure:
                    imageView.image = nil
                }
            }
        })
    }
    
    private func setupInformationStackView(withModel model: BadgeInfoModel) {
        titleAndSubtitleView.setup(title: model.title, subtitle: model.subtitle)
    }
    
    private func setupTrailing(info: String) {
        trailingLabel.text = info
        trailingLabel.isHidden = false
    }
    
    private func clearView() {
        iconImageView.image = nil
        iconImageView.isHidden = true
            
        trailingLabel.text = ""
        trailingLabel.isHidden = true
    }
}

class TitleAndLabelView: UIView {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UIView.makeUILabelWith(text: "")
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        return titleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UIView.makeUILabelWith(text: "")
        subtitleLabel.font = .boldSystemFont(ofSize: 16)
        
        return subtitleLabel
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setup(title: String,
               subtitle: String?) {
        clearView()
        titleLabel.text = title
        if let subtitle = subtitle {
            subtitleLabel.text = subtitle
        }
        setupViewsHierarchy(subtitle)
        setupViewsConstraints(subtitle)
    }
    
    private func setupViewsHierarchy(_ subtitle: String?) {
        addSubview(titleLabel)
        if let _ = subtitle {
            addSubview(subtitleLabel)
        }
    }
    
    private func setupViewsConstraints(_ subtitle: String?) {
        guard let _ = subtitle else {
            setupViewConstraintsWithoutSubtitle()
            return
        }
        setupViewConstraintsWithSubtitle()
    }
    
    private func setupViewConstraintsWithSubtitle() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
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
    
    private func clearView() {
        titleLabel.removeFromSuperview()
        subtitleLabel.removeFromSuperview()
    }
}
