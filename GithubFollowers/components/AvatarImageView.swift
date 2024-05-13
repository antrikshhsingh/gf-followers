//
//  AvatarImageView.swift
//  GithubFollowers
//
//  Created by Antriksh Singh on 11/05/24.
//

import UIKit

class AvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(contentMode: ContentMode){
        super.init(frame: .zero)
        self.contentMode = contentMode
        configure()
    }
    
    private func configure(){
        clipsToBounds = true
        layer.cornerRadius = 20
        backgroundColor = .systemGray
    }
    
}
