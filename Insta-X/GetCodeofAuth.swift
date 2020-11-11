//
//  GetCodeofAuth.swift
//  Insta-X
//
//  Created by Youssef Osama on 11/11/2020.
//

import Foundation
import UIKit

class GetCodeofAuth: UIViewController {
    
    @IBAction func sendCode(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EnterCode", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "EnterCode")
        navigationController?.pushViewController(vc, animated: true)
    }
}
