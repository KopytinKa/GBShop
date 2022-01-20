//
//  ApproveReviewRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation
import Alamofire

protocol ApproveReviewRequestFactory {
    func approveReview(idComment: Int, completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void)
}
