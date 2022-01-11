//
//  LoginResult.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.12.2021.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User
    let authToken: String
}
