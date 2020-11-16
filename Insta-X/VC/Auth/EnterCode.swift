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
        
        
        let request =  AF.request("https://alfreeej-store.com/insta/api/activate", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
        request.responseJSON { (response) in
            if let data = response.data {
                print(JSON(data))
                let decoder = JSONDecoder()
                if let LoginModel = try? decoder.decode(model2.self, from: data) {
                    self.handleRespnse(Model: LoginModel)
                }
            }
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    struct model2: Codable {
        let status: String
        let message: String
    }
    
    func handleRespnse(Model: model2) {
        if Model.status == "error" {
            showAlert(title: Model.status, message: Model.message)
        } else {
            showAlert(title: "success", message: "Entered Successfully")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
