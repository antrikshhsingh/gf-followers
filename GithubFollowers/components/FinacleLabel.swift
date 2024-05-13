//
//  FinacleLabel.swift
//  GithubFollowers
//
//  Created by Antriksh Singh on 11/05/24.
//

import UIKit

class FinacleLabel: UILabel {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(font:UIFont){
        super.init(frame: .zero)
        self.font = font
        configure()
    }
    
    private func configure(){
        textAlignment = .center
        textColor = .label
    }
    
}
