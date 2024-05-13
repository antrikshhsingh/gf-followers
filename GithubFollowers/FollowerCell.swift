//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Antriksh Singh on 10/05/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    let avatarImageView = AvatarImageView(contentMode: .scaleAspectFit)
    
    let usernameLabel = FinacleLabel(font:  UIFont.systemFont(ofSize: 14, weight: .medium))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            usernameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    func configure(with follower: Followers) {
        usernameLabel.text = follower.login
        if let url = URL(string: follower.avatarURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        self?.avatarImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
}
