//
//  CatalogRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 12.01.2022.
//

import Foundation
import Alamofire

protocol CatalogRequestFactory {
    func getCatalog(pageNumber: Int, idCategory: Int, completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void)
}
