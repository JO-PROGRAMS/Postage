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
        
        userNametxt.layer.borderColor = #colorLiteral(red: 0.8545786738, green: 0.853570044, blue: 0.9281356931, alpha: 1)
        userNametxt.layer.borderWidth = 0.8
        
        passwordTxt.layer.cornerRadius = 15
        passwordTxt.layer.borderColor = #colorLiteral(red: 0.8545786738, green: 0.853570044, blue: 0.9281356931, alpha: 1)
        passwordTxt.layer.borderWidth = 0.8
        
        signinBtn.layer.cornerRadius = 15
        
        signupBtn.layer.cornerRadius = 15
        signupBtn.layer.borderColor = UIColor.blue.cgColor
        signupBtn.layer.borderWidth = 0.8
        
        googleBtn.layer.cornerRadius = 15
        googleBtn.layer.borderColor = #colorLiteral(red: 0.8545786738, green: 0.853570044, blue: 0.9281356931, alpha: 1)
        googleBtn.layer.borderWidth = 0.8
        
        facebookBtn.layer.cornerRadius = 15
        facebookBtn.layer.borderColor = #colorLiteral(red: 0.8545786738, green: 0.853570044, blue: 0.9281356931, alpha: 1)
        facebookBtn.layer.borderWidth = 0.8
    }
    
    @IBAction func signInButton(_ sender: Any) {
        // check input is valid
        // call Api
        // check response
        // if success -> Enter Code
        // if fail -> "Show Alert with Message"
      
        
        
        guard let userName = userNametxt.text, userName.count > 5, userName.contains("@") else {
            showAlert(title: "Error", message: "Incorrect Username")
            return
        }
        
        guard let passWord = passwordTxt.text, passWord.count > 4 else {
            showAlert(title: "Error", message: "Incorrect Password")
            return
        }
        
        let baseURL = "https://alfreeej-store.com/insta/api/"
        
        let loginURL = baseURL + "login"
        
        let parameters = [
            "email" : userName,
            "password" : passWord
        ]
        
      let request =  AF.request(loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            request.responseJSON { (response) in
                if let data = response.data {
                    print(JSON(data))
                    let decoder = JSONDecoder()
                    if let LoginModel = try? decoder.decode(RegisterModel.self, from: data) {
                        self.handleRespnse(Model: LoginModel)
                    }
                }
               
            }
    
    }

    func handleRespnse(Model: RegisterModel) {
        if Model.status == "error" {
            showAlert(title: Model.status, message: Model.message)
        } else {
            showAlert(title: "success", message: "Entered Successfully")
            
        }
    }
    
    
    @IBAction func logInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AuthSB", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "SignUp")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

