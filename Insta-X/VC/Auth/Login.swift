//
//  LoginViewController.swift
//  Insta-X
//
//  Created by Youssef on 11/11/20.
//

import UIKit
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNametxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!

    let TabBarVC = TabBar()
    
    var loaderTwo = NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 150, height: 150), type: .orbit, color: #colorLiteral(red: 0.2998352051, green: 0.2986930907, blue: 0.9962851405, alpha: 1))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
       
        userNametxt.addPadding(padding: .left(10))
        passwordTxt.addPadding(padding: .left(10))
        
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
        
        view.addSubview(loaderTwo)
        loaderTwo.center = view.center
        loaderTwo.startAnimating()
        
        Network.Request(RegisterModel.self, url: loginURL, method: .post, parameters: parameters) { (model) in
            self.handleRespnse(Model: model)
            
            self.loaderTwo.stopAnimating()
            self.loaderTwo.isHidden = true
        } onFailure: { (error) in
            self.showAlert(title: "Error", message: error)
            self.loaderTwo.stopAnimating()
            self.loaderTwo.isHidden = true
        }

    }
    
    

    
    
    

  
    
    
    @IBAction func logInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AuthSB", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "SignUp")
        navigationController?.pushViewController(vc, animated: true)
    }
    



    
    func handleRespnse(Model: RegisterModel) {
        if Model.status == "error" {
            showAlert(title: Model.status, message: Model.message)
        } else {
           
            navigationController?.pushViewController(self.TabBarVC, animated: true)
            navigationController?.navigationBar.isHidden = true
            
        }
    }

}


