//
//  RegisterViewController.swift
//  GBShop
//
//  Created by Кирилл Копытин on 21.01.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var mailInput: UITextField!
    @IBOutlet weak var genderInput: UISegmentedControl!
    @IBOutlet weak var cardInput: UITextField!
    @IBOutlet weak var bioInput: UITextView!
    
    private var selectedGender: Gender {
        switch self.genderInput.selectedSegmentIndex {
        case 0:
            return .m
        case 1:
            return .f
        default:
            return .m
        }
    }
    
    private let requestFactory = RequestFactory()
    
    let fromRegisterToMainScreensSegueIdentifier = "fromRegisterToMainScreen"
    
    @IBAction func pressRegisterButton(_ sender: Any) {
        if let login = loginInput.text, !login.isEmpty,
           let password = passwordInput.text, !password.isEmpty,
           let email = mailInput.text, !email.isEmpty,
           let bio = bioInput.text, !bio.isEmpty,
           let creditCard = cardInput.text, !creditCard.isEmpty
        {
            checkResult(login: login, password: password, email: email, gender: selectedGender, creditCard: creditCard, bio: bio)
        } else {
            showError("Заполни все поля")
        }
    }
    
    func checkResult(login: String, password: String, email: String, gender: Gender, creditCard: String, bio: String) {
        let register = requestFactory.makeRegisterUserRequestFactory()
        register.register(
            userId: Int.random(in: 0..<999),
            login: login,
            password: password,
            email: email,
            gender: gender,
            creditCard: creditCard,
            bio: bio
        ) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let register):
                if register.result != 0 {
                    self.performSegue(withIdentifier: self.fromRegisterToMainScreensSegueIdentifier, sender: nil)
                } else {
                    self.showError(register.errorMessage ?? "Введены неверные данные")
                }
            case .failure(let error):
                self.showError(error.localizedDescription)
            }
        }
    }
}
