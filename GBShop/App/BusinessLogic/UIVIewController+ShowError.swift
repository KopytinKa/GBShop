//
//  UIVIewController+ShowError.swift
//  GBShop
//
//  Created by Кирилл Копытин on 23.01.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
