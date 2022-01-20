//
//  AddReviewRequestFactory.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.01.2022.
//

import Foundation
import Alamofire

protocol AddReviewRequestFactory {
    func addReview(idUser: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
}
