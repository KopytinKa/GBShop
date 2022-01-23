//
//  ProfileViewController.swift
//  GBShop
//
//  Created by Кирилл Копытин on 21.01.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var mailInput: UITextField!
    @IBOutlet weak var genderInput: UISegmentedControl!
    @IBOutlet weak var cardInput: UITextField!
    @IBOutlet weak var bioInput: UITextView!
    @IBOutlet weak var changeDataButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveDataButton: UIButton!
    
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
    
    let fromProfileToAuthSegueIdentifier = "fromProfileToAuth"
    
    
    @IBAction func pressChangeDataButton(_ sender: Any) {
        toggleForm()
    }
    
    @IBAction func pressCancelButton(_ sender: Any) {
        toggleForm()
    }
    
    @IBAction func pressSaveDataButton(_ sender: Any) {
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
    
    @IBAction func pressExitButton(_ sender: Any) {
        let exit = requestFactory.makeExitRequestFactory()
        exit.logout(userId: Int.random(in: 0..<999)) { response in
            switch response.result {
            case .success(let exit):
                if exit.result != 0 {
                    self.performSegue(withIdentifier: self.fromProfileToAuthSegueIdentifier, sender: nil)
                } else {
                    print(exit.errorMessage ?? "Неизвестная ошибка")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func checkResult(login: String, password: String, email: String, gender: Gender, creditCard: String, bio: String) {
        let changeData = requestFactory.makeChangeUserDataRequestFactory()
        changeData.changeData(
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
            case .success(let changeData):
                if changeData.result != 0 {
                    self.toggleForm()
                } else {
                    self.showError(changeData.errorMessage ?? "Введены неверные данные")
                }
            case .failure(let error):
                self.showError(error.localizedDescription)
            }
        }
    }
    
    func toggleForm() {
        self.changeDataButton.isHidden.toggle()
        self.cancelButton.isHidden.toggle()
        self.saveDataButton.isHidden.toggle()
        
        self.loginInput.isEnabled.toggle()
        self.passwordInput.isEnabled.toggle()
        self.mailInput.isEnabled.toggle()
        self.genderInput.isEnabled.toggle()
        self.cardInput.isEnabled.toggle()
        self.bioInput.isEditable.toggle()
    }
}
