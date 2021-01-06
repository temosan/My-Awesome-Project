//
//  New_mainTableView.swift
//  Sample001-Swift
//
//  Created by 김희중 on 2021/01/05.
//

import UIKit

class New_TableViewCell: UITableViewCell {
    
    var data: new_test_model? {
        didSet {
            if let label1Name = data?.id {
                label1.text = "\(label1Name)"
            }
            
            if let label2Name = data?.status {
                label2.text = label2Name
            }
            
            if let label3Name = data?.downloadurl {
                label3.text = label3Name
            }
            
            if let label4Name = data?.description {
                label4.text = label4Name
            }
        }
    }
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .gray
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

        stackview.frame = CGRect(x: 10, y: 0, width: self.frame.width-10, height: self.frame.height)
    }

    
}
