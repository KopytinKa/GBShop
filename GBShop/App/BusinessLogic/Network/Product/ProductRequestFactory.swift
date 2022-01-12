//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 12.01.2022.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func getDataById(_ id: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}
