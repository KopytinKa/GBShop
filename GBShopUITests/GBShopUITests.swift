//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Кирилл Копытин on 14.12.2021.
//

import XCTest

class GBShopUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    func testSuccess() {
        enterAuthData(login: "123", password: "123")
    }
    
    func testFail() {
        enterAuthData(login: "user", password: "password")
    }


    private func enterAuthData(login: String, password: String) {
        let loginTextField = self.app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(login)
        
        let passwordTextField = self.app.secureTextFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        self.app.buttons["enter"].tap()
    }
}
