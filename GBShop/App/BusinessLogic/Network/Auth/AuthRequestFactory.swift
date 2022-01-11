//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.12.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
