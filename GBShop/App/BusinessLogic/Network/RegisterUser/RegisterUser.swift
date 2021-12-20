//
//  RegisterUser.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.12.2021.
//

import Foundation
import Alamofire

class RegisterUser: AbstractRequestFactory {
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

extension RegisterUser: RegisterUserRequestFactory {
    func register(
        userId: Int,
        login: String,
        password: String,
        email: String,
        gender: Gender,
        creditCard: String,
        bio: String,
        completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void
    ) {
        let requestModel = Register(
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

extension RegisterUser {
    struct Register: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
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
