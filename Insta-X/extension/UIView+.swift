//
//  UIView+.swift
//  Insta-X
//
//  Created by Youssef on 14/11/2020.
//

import UIKit

extension UIView {

    @IBInspectable
    var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        } get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    // layer.cornerRadius
}
