//
//  SignUp.swift
//  Insta-X
//
//  Created by Youssef Osama on 15/11/2020.
//What happened here?


import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class SignUp: UIViewController {
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Pass: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var PassConf: UITextField!
    @IBAction func AcceptButt(_ sender: Any) {
        
    }
    let userImage = #imageLiteral(resourceName: "Photo")
    
    @IBAction func LoginButton(_ sender: Any) {
        
        
        
        guard let username = Username.text, username.count >= 4 else {
            
            showAlert(title: "Invalid Username", message: "Must be more than 4 characters")
            
            return
        }
        
        guard let phone = Phone.text, phone.count > 4 else {
            
            showAlert(title: "Invalid Phone Number", message: "Phone number must be atleast 4 numbers")
            
            return
        }
        
        guard let email = emailTxt.text, email.count > 6, email.contains("@") else {
            showAlert(title: "Invalid Email", message: "Enter a valid Email")
            return
        }
        
        
        guard let pass = Pass.text, pass.count >= 5 else {
            
            showAlert(title: "Invalid Password", message: "Password must be atleast 5 characters")
            
            return
        }
        
        guard let passconf = PassConf.text, passconf == pass else {
            
            showAlert(title: "Invalid Password", message: "Password are not the same")
            
            return
        }
        
        
        let body: [String: Any] = [
            "username": username,
            "password": pass,
            "email": email,
            "mobile": phone,
            "country_id": 1
        ]
        
        let url = "https://skyline4it.com/insta/api/signup"
        
        let uploadRequest =  AF.upload(multipartFormData: { (MultipartFormData) in
            
            MultipartFormData.append(self.userImage.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "image.png", mimeType: "image/png")
            
            for (key, value) in body {
                MultipartFormData.append("\(value)".data(using: (.utf8))!, withName: key)
            }
            
        }, to: url, method: .post, headers: nil)
        
        
        uploadRequest.responseJSON { (response) in
            let data = response.data
            print(JSON(data))
            let decoder = JSONDecoder()
            if let signModel = try? decoder.decode(RegisterModel.self, from: data!) {
                
                self.handleRespnse(Model: signModel)
                
            }
        }
        
        
        
    }
    
    
    func handleRespnse(Model: RegisterModel) {
        if Model.status == "error" {
            showAlert(title: Model.status, message: Model.message)
        } else {
//            showAlert(title: Model.status, message: Model.message)
            let email = Model.data?.email
            let storyboard = UIStoryboard(name: "AuthSB", bundle: .main)
            let vc = storyboard.instantiateViewController(identifier: "EnterCode") as! EnterCode
            vc.email = email
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
}
