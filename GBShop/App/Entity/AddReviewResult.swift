//
//  AddReviewResult.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation

struct AddReviewResult: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}
