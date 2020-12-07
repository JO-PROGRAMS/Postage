//
//  Networking.swift
//  Insta-X
//  Created by Youssef Osama on 22/11/2020.
//
//  __,
// (           o  /) _/_
//  `.  , , , ,  //  /
// (___)(_(_/_(_ //_ (__
//            /)
//           (/

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class Network {
    
    static var network = Network()
    
    
    
    static func Request <T : Codable> (_ : T.Type,url: String, method: HTTPMethod = .get, parameters: [String: Any] = [:], onSuccess: @escaping ((_ model: T) -> ()), onFailure: @escaping ((_ model: String) -> ())  ){
        
        var encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        
        
        let request =  AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: nil)
        request.responseJSON { (response) in
            
            
            switch response.result {
            
            case .success(_) :
            if let data = response.data {
                print(JSON(data))
                let decoder = JSONDecoder()
           
                do {
                    let requestModel = try decoder.decode(T.self, from: data)
                       onSuccess(requestModel)
                } catch {
                    print(error)
                    onFailure(error.localizedDescription)
                }
                
            } else {
               onFailure("No Data Recieved")
            }
            case .failure(let error):
                onFailure(error.localizedDescription)
            }
        }
        
    }
    
    
    
    func upload <T: Codable>(_ : T.Type ,url: String, userImage: UIImage, body: [String : Any] = [:], method: HTTPMethod = .post, onSuccess: @escaping ((_ model: T) -> ()), onFailure: @escaping ((_ model: String) -> ()) ) {
        
        let uploadRequest =  AF.upload(multipartFormData: { (MultipartFormData) in
            
            MultipartFormData.append(userImage.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "image.png", mimeType: "image/png")
            
            for (key, value) in body {
                MultipartFormData.append("\(value)".data(using: (.utf8))!, withName: key)
            }
            
        }, to: url, method: method, headers: nil)
        
        
        uploadRequest.responseJSON { (response) in
            switch response.result {
            
            case .success(_) :
            if let data = response.data {
                print(JSON(data))
                let decoder = JSONDecoder()
           
                do {
                    let requestModel = try decoder.decode(T.self, from: data)
                       onSuccess(requestModel)
                } catch {
                    print(error)
                    onFailure(error.localizedDescription)
                }
                
            } else {
               onFailure("No Data Recieved")
            }
            case .failure(let error):
                onFailure(error.localizedDescription)
            }
                
            }
        }
        
        
        
        
    }
    
    




