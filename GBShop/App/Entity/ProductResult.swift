//
//  ProductResult.swift
//  GBShop
//
//  Created by Кирилл Копытин on 12.01.2022.
//

import Foundation

struct ProductResult: Codable {
    let result: Int
    let product: ProductModel?
    let errorMessage: String?
}
