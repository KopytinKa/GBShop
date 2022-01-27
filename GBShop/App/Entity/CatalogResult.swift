//
//  CatalogResult.swift
//  GBShop
//
//  Created by Кирилл Копытин on 12.01.2022.
//

import Foundation

struct CatalogResult: Codable {
    let pageNumber: Int
    let products: [ProductResult]
    
    enum CodingKeys: String, CodingKey {
        case products
        case pageNumber = "page_number"
    }
}
