//
//  thirdCollectionViewHeader.swift
//  Sample001-Swift
//
//  Created by 김희중 on 2021/01/06.
//

import UIKit

class thirdCollectionViewCellHeader: UICollectionViewCell  {
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemPink
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayouts() {
        addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
}
