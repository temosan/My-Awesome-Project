//
//  thirdCollectionViewCell.swift
//  Sample001-Swift
//
//  Created by 김희중 on 2021/01/06.
//

import UIKit

class thirdCollectionViewCell: UICollectionViewCell {
    
    let stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        addSubview(stackview)
        stackview.addArrangedSubview(label1)
        stackview.addArrangedSubview(label2)
        stackview.addArrangedSubview(label3)
        stackview.addArrangedSubview(label4)

        stackview.frame = CGRect(x: 0, y: 0, width: self.frame.width-10, height: self.frame.height)
    }
}
