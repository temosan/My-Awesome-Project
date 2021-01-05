//
//  mainCollectionViewCell.swift
//  neowiz_heejung
//
//  Created by 김희중 on 2021/01/05.
//

import UIKit
class mainCollectionViewCell: UICollectionViewCell {
    
    var data: testModel? {
        didSet {
            if let imageName = data?.image {
                testImageView.image = UIImage(named: imageName)
            }
            
            if let label1Name = data?.label1 {
                label1.text = label1Name
            }
            
            if let label2Name = data?.label2 {
                label2.text = label2Name
            }
        }
    }
    
    let testImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 12
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupLayouts() {
        backgroundColor = .gray
        
        addSubview(testImageView)
        addSubview(stackview)
        stackview.addArrangedSubview(label1)
        stackview.addArrangedSubview(label2)

        testImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(-8)
            make.width.equalTo(120)
        }
        stackview.snp.makeConstraints { (make) in
            make.top.equalTo(testImageView.snp.top)
            make.bottom.equalTo(testImageView.snp.bottom)
            make.left.equalTo(testImageView.snp.right).offset(12)
            make.right.equalTo(self)
        }

    }
}
