//
//  ExitRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.12.2021.
//

import Foundation
import Alamofire

protocol ExitRequestFactory {
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
