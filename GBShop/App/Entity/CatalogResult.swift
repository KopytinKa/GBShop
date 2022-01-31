//
//  CatalogResult.swift
//  GBShop
//
//  Created by Кирилл Копытин on 12.01.2022.
//

import Foundation

struct CatalogResult: Codable {
    let result: Int
    let pageNumber: Int?
    let products: [ProductModel]?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case products, result, errorMessage
        case pageNumber = "page_number"
    }
}
