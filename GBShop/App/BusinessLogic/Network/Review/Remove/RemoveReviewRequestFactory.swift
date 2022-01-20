//
//  RemoveReviewRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation
import Alamofire

protocol RemoveReviewRequestFactory {
    func removeReview(idComment: Int, completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
}
