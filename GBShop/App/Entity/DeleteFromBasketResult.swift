//
//  DeleteFromBasketResult.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation

struct DeleteFromBasketResult: Codable {
    let result: Int
    let errorMessage: String?
}
