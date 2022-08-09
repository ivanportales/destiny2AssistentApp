//
//  DestinyAccountTableViewCell.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 09/08/22.
//

import UIKit

class DestinyAccountTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "destinyAccountTableViewCell"
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UIView.makeUILabelWith(text: "")
        return nameLabel
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
        nameLabel.text = account.displayName
    }
        
    private func setupView() {
        contentView.backgroundColor = .white
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
