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
    
    @IBAction func pressChangeDataButton(_ sender: Any) {
        unlockForm()
    }
    
    @IBAction func pressCancelButton(_ sender: Any) {
        lockForm()
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
                    self.lockForm()
                } else {
                    self.showError(changeData.errorMessage ?? "Введены неверные данные")
                }
            case .failure(let error):
                self.showError(error.localizedDescription)
            }
        }
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func lockForm() {
        self.changeDataButton.isHidden = false
        self.cancelButton.isHidden = true
        self.saveDataButton.isHidden = true
        
        self.loginInput.isEnabled = false
        self.passwordInput.isEnabled = false
        self.mailInput.isEnabled = false
        self.genderInput.isEnabled = false
        self.cardInput.isEnabled = false
        self.bioInput.isEditable = false
    }
    
    func unlockForm() {
        self.changeDataButton.isHidden = true
        self.cancelButton.isHidden = false
        self.saveDataButton.isHidden = false
        
        self.loginInput.isEnabled = true
        self.passwordInput.isEnabled = true
        self.mailInput.isEnabled = true
        self.genderInput.isEnabled = true
        self.cardInput.isEnabled = true
        self.bioInput.isEditable = true
    }
}
