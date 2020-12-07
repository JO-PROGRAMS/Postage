//
//  CountriesModel.swift
//  Insta-X
//
//  Created by Youssef Osama on 20/11/2020.
//

import Foundation



// MARK: - Welcome
struct CountriesModel: Codable {
    let data: [CountryModelData]?
    let status, message: String
}

// MARK: - Datum
struct CountryModelData: Codable {
    let name: String
    let image: String
    let dialCode: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name, image
        case dialCode = "dial_code"
        case id
    }
}
