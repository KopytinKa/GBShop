//
//  ViewController.swift
//  GBShop
//
//  Created by Кирилл Копытин on 14.12.2021.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    private let requestFactory = RequestFactory()
    
    let fromAuthToMainScreensSegueIdentifier = "fromAuthToMainScreen"

    @IBAction func pressLoginButton(_ sender: Any) {
        if let login = loginInput.text, !login.isEmpty,
           let password = passwordInput.text, !password.isEmpty
        {
            checkResult(userName: login, password: password)
        } else {
            showError("Заполни все поля")
        }
    }
    
    func checkResult(userName: String, password: String) {
        let auth = self.requestFactory.makeAuthRequestFactory()
        auth.login(userName: userName, password: password) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let login):
                if login.result != 0 {
                    Crashlytics.crashlytics().log("login success")
                    self.performSegue(withIdentifier: self.fromAuthToMainScreensSegueIdentifier, sender: nil)
                } else {
                    let message = login.errorMessage ?? "Введены неверные данные пользователя"
                    Crashlytics.crashlytics().log(message)
                    self.showError(message)
                }
            case .failure(let error):
                Crashlytics.crashlytics().log(error.localizedDescription)
                self.showError(error.localizedDescription)
            }
        }
    }
}

