//
//  GetCodeViewController.swift
//  Insta-X
//
//  Created by Youssef Osama on 09/11/2020.
//

import Foundation
import UIKit


class UIGetCodeViewController: UIViewController {
    
    @IBAction func getCodeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "ViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}


