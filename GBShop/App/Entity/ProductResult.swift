//
//  ProductResult.swift
//  GBShop
//
//  Created by Кирилл Копытин on 12.01.2022.
//

import Foundation

struct ProductResult: Codable {
    let result: Int?
    let name: String
    let price: Int?
    let productPrice: Int?
    let description: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case result, price
        case name = "product_name"
        case productPrice = "product_price"
        case description = "product_description"
        case id = "id_product"
    }
}
