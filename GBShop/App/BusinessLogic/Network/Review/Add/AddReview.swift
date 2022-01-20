//
//  AddReview.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation
import Alamofire

class AddReview: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://afternoon-ravine-72981.herokuapp.com/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension AddReview: AddReviewRequestFactory {
    func addReview(idUser: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = Add(baseUrl: baseUrl, idUser: idUser, text: text)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension AddReview {
    struct Add: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        
        let idUser: Int
        let text: String
        var parameters: Parameters? {
            return [
                "id_user": idUser,
                "text": text
            ]
        }
    }
}
