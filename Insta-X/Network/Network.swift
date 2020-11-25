//
//  Network.swift
//  Insta-X
//
//  Created by Youssef on 21/11/2020.
//

import Foundation
import SwiftyJSON
import Alamofire

class Network {
    
    static func request<T>(_ modelType: T.Type, url: String, body: [String: Any]? = nil, method: HTTPMethod = .get, onSuccess: @escaping (_ data: T) -> (), onError: @escaping (_ error: String) -> ()) where T: Codable {
        
        let encodig: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        
        let request = AF.request(url, method: method, parameters: body, encoding: encodig, headers: nil)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success(_):
                    if let data = response.data {
                        print(JSON(data))
                        let decoder = JSONDecoder()
                        if let requestModel = try? decoder.decode(T.self, from: data) {
                            onSuccess(requestModel)
                        } else {
                            onError("Model Not As Same As Json")
                        }
                    } else {
                        onError("No Data On Response")
                    }
                case .failure(let error):
                    onError(error.localizedDescription)
            }
        }
    }
    
    static func upload<T: Codable>(_ modelType: T.Type, url: String, body: [String: Any]? = nil, imageToUpload: UIImage, method: HTTPMethod = .post, callBack: @escaping ((_ data: T) -> ())) {
        let request = AF.upload(multipartFormData: { (multipartFormData) in
            
            let myImageAsData = imageToUpload.jpegData(compressionQuality: 0.5)!
            multipartFormData.append(myImageAsData, withName: "image", fileName: "image.png", mimeType: "image/png")
            
            for (key, value) in body ?? [:] {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
        }, to: url, method: method, headers: nil)
        
        request.responseJSON { (response) in
            if let data = response.data {
                print(JSON(data))
                let decoder = JSONDecoder()
                if let uploadResonseModel = try? decoder.decode(modelType.self, from: data) {
                    callBack(uploadResonseModel)
                }
            }
        }
    }
}

enum ClassStudents {
    case youssef(id: Int)
    case mohamed(id: Int)
    case ali(id: Int)
}


class TestEnum {
    
    var classStudent: ClassStudents = .youssef(id: 1)
    
    func test() {
        switch classStudent {
            case .youssef(let id):
                print("youssef id: " + id.string)
            case .mohamed:
                print("mohamed")
            case .ali:
                print("ali")
        }
    }
}

extension Int {
    var string: String {
        return "\(self)"
    }
}
