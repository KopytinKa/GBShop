//
//  ChangeUserData.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.12.2021.
//

import Foundation
import Alamofire

class ChangeUserData: AbstractRequestFactory {
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

extension ChangeUserData: ChangeUserDataRequestFactory {
    func changeData(
        userId: Int,
        login: String,
        password: String,
        email: String,
        gender: Gender,
        creditCard: String,
        bio: String,
        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void
    ) {
        let requestModel = ChangeData(
            baseUrl: baseUrl,
            userId: userId,
            login: login,
            password: password,
            email: email,
            gender: gender,
            creditCard: creditCard,
            bio: bio
        )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ChangeUserData {
    struct ChangeData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        
        let userId: Int
        let login: String
        let password: String
        let email: String
        let gender: Gender
        let creditCard: String
        let bio: String
        
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "username": login,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
}
