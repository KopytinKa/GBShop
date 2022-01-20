//
//  ProductModel.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation

struct ProductModel: Codable {
    let id: Int
    let name: String
    let price: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}
