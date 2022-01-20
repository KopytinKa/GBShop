//
//  ApproveReview.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation
import Alamofire

class ApproveReview: AbstractRequestFactory {
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

extension ApproveReview: ApproveReviewRequestFactory {
    func approveReview(idComment: Int, completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void) {
        let requestModel = Approve(baseUrl: baseUrl, idComment: idComment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ApproveReview {
    struct Approve: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "approveReview"
        
        let idComment: Int
        var parameters: Parameters? {
            return [
                "id_comment": idComment
            ]
        }
    }
}
