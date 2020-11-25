//
//  LoginViewController.swift
//  Insta-X
//
//  Created by Youssef on 11/11/20.
//

import UIKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNametxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNametxt.layer.cornerRadius = 15
        userNametxt.layer.borderColor = UIColor.gray.cgColor
        userNametxt.layer.borderWidth = 0.8
        
        passwordTxt.layer.cornerRadius = 15
        // passwordTxt.layer.borderColor = UIColor.gray.cgColor
        passwordTxt.borderColor = .gray
        passwordTxt.layer.borderWidth = 0.8
        
        signinBtn.layer.cornerRadius = 15
        
        signupBtn.layer.cornerRadius = 15
        signupBtn.layer.borderColor = UIColor.blue.cgColor
        signupBtn.layer.borderWidth = 0.8
        
        googleBtn.layer.cornerRadius = 15
        googleBtn.layer.borderColor = #colorLiteral(red: 0.8545786738, green: 0.853570044, blue: 0.9281356931, alpha: 1)
        googleBtn.layer.borderWidth = 0.8
        
        facebookBtn.layer.cornerRadius = 15
        facebookBtn.layer.borderColor = UIColor.gray.cgColor
        facebookBtn.layer.borderWidth = 0.8
    }
    
    @IBAction func signInButton(_ sender: Any) {
        // check if mail is valid mail
        guard let userMail = userNametxt.text, userMail.count > 4 else {
            showAlert(title: "Error", message: "Please Enter Your Mail")
            return
        }
        
        guard let password = passwordTxt.text, password.count > 4 else {
            showAlert(title: "Error", message: "Please Enter Your Valid Password")
            return
        }
        
        let loginUrl = Constants.baseUrl + "login"
        
        let body = [
            "email": userMail,
            "password": password
        ]
        
        // post -> JSONEncoding
        // GET -> URLEncoding
        
        Network.request(LoginModel.self, url: loginUrl, body: body, method: .post) { (model) in
            self.handleApiResonse(loginModel: model)
        } onError: { error in
            self.showAlert(title: "Error", message: error)
        }
    }
    
    func handleApiResonse(loginModel: LoginModel) {
        if loginModel.status == "error" {
            showAlert(title: "error", message: loginModel.message ?? "")
        } else if loginModel.status == "success" {
            showAlert(title: "success", message: loginModel.message ?? "")
        }
    }
    
    @IBAction func logInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AuthSB", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "RegisterViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

struct LoginModel: Codable {
    let status: String?
    let message: String?
    // let data: ??
}
