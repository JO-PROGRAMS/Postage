//
//  ShowAlertExtensions.swift
//  Insta-X
//
//  Created by Youssef Osama on 15/11/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    

    
}




struct SignInModel: Codable {
    let data: dataClass
    let message, status: String
}

// MARK: - DataClass
struct dataClass: Codable {
    let code, email: String
}

// MARK: - Welcome
struct RegisterModel: Codable {
    let message: String
    let status: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let hideFollowers: JSONNull?
    let accessToken: String?
    let isActive: Int?
    let email: String
    let id, isSocial: Int?
    let image: String
    let social: Social?
    let mobile, username: String
    let country: Country

    enum CodingKeys: String, CodingKey {
        case hideFollowers = "hide_followers"
        case accessToken = "access_token"
        case isActive = "is_active"
        case email, id
        case isSocial = "is_social"
        case image, social, mobile, username, country
    }
}




// MARK: - Country
struct Country: Codable {
    let name: String
    let image: String
    let id: Int
    let dialCode: String

    enum CodingKeys: String, CodingKey {
        case name, image, id
        case dialCode = "dial_code"
    }
}

// MARK: - Social
struct Social: Codable {
    let id, type: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
