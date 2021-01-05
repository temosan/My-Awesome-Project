//
//  UIVIew+.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/05.
//

import UIKit

extension UIView {
    /// addSubView 한번에 하기
    func addSubViews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
    
    /// 태두리 그리기 한번에 하기
    func setBorder(borderWidth: CGFloat = 0, borderColor: UIColor = .clear, cornerRadius: CGFloat = 0, maskToBounds: Bool = true) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = maskToBounds
    }
}
