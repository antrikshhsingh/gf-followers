//
//  FinacleView.swift
//  GithubFollowers
//
//  Created by Antriksh Singh on 11/05/24.
//

import UIKit

class FinacleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemGray3
        layer.cornerRadius = 20
        
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let superview = superview else {
            print("Error: FinacleView has no superview")
            return
        }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 10),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10),
            heightAnchor.constraint(equalToConstant: 200),
        ])
    }


    
}
