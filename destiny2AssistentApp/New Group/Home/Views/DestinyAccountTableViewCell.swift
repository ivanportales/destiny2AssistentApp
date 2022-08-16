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
    
    func set(account: DestinyAccount) {
        badgeInfoView.set(model: account)
    }
        
    private func setupView() {
        contentView.backgroundColor = .clear
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(badgeInfoView)
    }
    
    private func setupConstraints() {
        badgeInfoView.constraintViewToSuperview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
