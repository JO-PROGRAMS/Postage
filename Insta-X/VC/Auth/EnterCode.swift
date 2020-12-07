//
//  EnterCode.swift
//  Insta-X
//
//  Created by Youssef Osama on 11/11/2020.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class loginVc {
    
    let hey = "hey"
    
    
}

class clone: loginVc {
    
    let ok = "ok"
    
}

class EnterCode: UIViewController {
    
    @IBOutlet weak var CodeTXT: UITextField!
    
    var email: String?
    
    
    @IBAction func enterCode(_ sender: Any) {
        
        guard let Code = CodeTXT.text, Code.count == 4 else {
            showAlert(title: "Erroe", message: "Code not valid")
            
            return
        }
        
        
        let parameter = [
            "code": Code,
            "email": email ?? "",
        ]
        
        let headers = [
            "Accept": "application/json",
                "Content-Type": "application/json"
        ]
        
        
        let request =  AF.request("https://alfreeej-store.com/insta/api/activate", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: .init(headers))
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
    
    
    
    let vc = loginVc.self

    
    func handleRespnse(Model: RegisterModel) {
        if Model.status == "error" {
            showAlert(title: Model.status, message: Model.message)
        } else {
            UserDefaults.standard.setValue(Model.data.accessToken, forKey: "accessToken")
            navigationController?.pushViewController(TabBar(), animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
