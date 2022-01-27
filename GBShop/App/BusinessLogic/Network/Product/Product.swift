//
//  Product.swift
//  GBShop
//
//  Created by Кирилл Копытин on 12.01.2022.
//

import Foundation
import Alamofire

class Product: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension Product: ProductRequestFactory {
    func getDataById(_ id: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
        let requestModel = GoodById(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Product {
    struct GoodById: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        
        let id: Int
        var parameters: Parameters? {
            return [
                "id_product": id
            ]
        }
    }
}
