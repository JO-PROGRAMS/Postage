//
//  extensions.swift
//  Insta-X
//
//  Created by Youssef Osama on 15/11/2020.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
             layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
    }
    
}
    

}
