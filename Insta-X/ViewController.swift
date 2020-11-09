//
//  ViewController.swift
//  Insta-X
//
//  Created by Youssef Osama on 09/11/2020.
//
import SwiftyJSON
import UIKit
import Alamofire
class ViewController: UIViewController {
    
    let body = [
        "mobile": "0100999333",
        "password": "123Abc"
    ]
    
    func callTheEndPoint(type: HTTPMethod, url: String, parameters: [String: Any]) {
        
        var encoding: ParameterEncoding = JSONEncoding.default
        
        if type == .get {
            encoding = URLEncoding.default
        }
        
        let AFrequest = AF.request(url, method: type, parameters: parameters, encoding: encoding, headers: nil)
        AFrequest.responseJSON { (AFresponse) in
            
            if let JSONdata = AFresponse.data {
                let json = JSON(JSONdata)
                print(json)
                
            }
            
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
        // Do any additional setup after loading the view.
        callTheEndPoint(type: .post, url: "https://skyline4it.com/insta/api/signup", parameters: body)
    }
    
    @IBAction func getCode(_ sender: Any) {
        let storyboard = UIStoryboard(name: "GetCode", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "UIGetCodeViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
