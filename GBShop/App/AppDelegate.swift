//
//  AppDelegate.swift
//  GBShop
//
//  Created by Кирилл Копытин on 14.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let requestFactory = RequestFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let exit = requestFactory.makeExitRequestFactory()
        exit.logout(userId: 123) { response in
            switch response.result {
            case .success(let id):
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let changeData = requestFactory.makeChangeUserDataRequestFactory()
        changeData.changeData(userId: 123, login: "Somebody", password: "mypassword", email: "some@some.ru", gender: .m, creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let id):
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let register = requestFactory.makeRegisterUserRequestFactory()
        register.register(userId: 123, login: "Somebody", password: "mypassword", email: "some@some.ru", gender: .m, creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let id):
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let product = requestFactory.makeProductRequestFactory()
        product.getDataById(123) { response in
            switch response.result {
            case .success(let id):
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        let catalog = requestFactory.makeCatalogRequestFactory()
        catalog.getCatalog(pageNumber: 1, idCategory: 1) { response in
            switch response.result {
            case .success(let id):
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let addReview = requestFactory.makeAddReviewRequestFactory()
        addReview.addReview(idUser: 123, text: "sdfsdfsf") { response in
            switch response.result {
            case .success(let id):
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let removeReview = requestFactory.makeRemoveReviewRequestFactory()
        removeReview.removeReview(idComment: 1) { response in
            switch response.result {
            case .success(let id):
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let approveReview = requestFactory.makeApproveReviewRequestFactory()
        approveReview.approveReview(idComment: 1) { response in
            switch response.result {
            case .success(let id):
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return true

    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

