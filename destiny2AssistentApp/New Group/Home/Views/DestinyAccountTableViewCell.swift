//
//  DestinyAccountTableViewCell.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 09/08/22.
//

import UIKit

class DestinyAccountTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "destinyAccountTableViewCell"
    
    lazy var badgeInfoView: BadgeInfoView = {
        let badgeInfoView = BadgeInfoView()
        return badgeInfoView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view does not support Storyboard!")
    }
    
    func set(viewModel: BadgeInfoViewModel) {
        badgeInfoView.set(viewModel: viewModel)
    }
        
    private func setupView() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(badgeInfoView)
    }
    
    private func setupConstraints() {
        let topConstraint = badgeInfoView.topAnchor.constraint(equalTo: contentView.topAnchor)
        topConstraint.priority = .init(rawValue: 999)
        NSLayoutConstraint.activate([
            topConstraint,
            badgeInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            badgeInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            badgeInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
