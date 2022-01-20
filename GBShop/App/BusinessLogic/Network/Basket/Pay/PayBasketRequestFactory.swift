//
//  PayBasketRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation
import Alamofire

protocol PayBasketRequestFactory {
    func payBasket(idUser: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void)
}
