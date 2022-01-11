//
//  RegisterUserRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.12.2021.
//

import Foundation
import Alamofire

protocol RegisterUserRequestFactory {
    func register(
        userId: Int,
        login: String,
        password: String,
        email: String,
        gender: Gender,
        creditCard: String,
        bio: String,
        completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void
    )
}
