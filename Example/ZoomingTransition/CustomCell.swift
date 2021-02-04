//
//  CustomCell.swift
//  ZoomingTransition_Example
//
//  Created by Desong on 2021/2/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
class CustomCell: UICollectionViewCell {
    var imageView = UIImageView()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        self.setupUI()
        
    }
    
    func setupUI(){
        
        contentView.addSubview(self.imageView)
        imageView.snp.makeConstraints{(make)in
            make.leading.trailing.top.bottom.equalToSuperview()
            
        }
        imageView.contentMode = .scaleAspectFit
        
    }
}
