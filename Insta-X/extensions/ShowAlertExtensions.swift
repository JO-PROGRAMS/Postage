//
//  ShowAlertExtensions.swift
//  Insta-X
//
//  Created by Youssef Osama on 15/11/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    

    
}

struct RegisterModel: Codable {
    let status: String
    let message: String
    let data: RegisterCodeModel?
}

struct RegisterCodeModel: Codable {
    let code: String?
    let email: String?
}
