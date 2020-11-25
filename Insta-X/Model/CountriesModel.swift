//
//  CountriesModel.swift
//  Insta-X
//
//  Created by Youssef on 18/11/2020.
//

import Foundation

// MARK: - Object
struct CountriesModel: Codable {
    let data: [CountriesModelElement]?
    let message, status: String?
}

// MARK: - Datum
struct CountriesModelElement: Codable {
    let name, dialCode: String?
    let image: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case image, id
    }
}
