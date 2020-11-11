//
//  GetCodeViewController.swift
//  Insta-X
//
//  Created by Youssef Osama on 09/11/2020.
//
import Foundation
import UIKit

class UIGetCode: UIViewController {

    @IBAction func signInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "GetCodeofAuth", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "GetCodeofAuth")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logInButton(_ sender: Any) {
        
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(identifier: "ViewController")
            navigationController?.pushViewController(vc, animated: true)
    }
    
}






