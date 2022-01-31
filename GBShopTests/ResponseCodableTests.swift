//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Кирилл Копытин on 11.01.2022.
//

import XCTest
import Alamofire
@testable import GBShop

class ResponseCodableTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Download https://afternoon-ravine-72981.herokuapp.com/")
    var errorParser: ErrorParser!

    override func setUp() {
        super.setUp()
        errorParser = ErrorParser()
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
    }
    
    func testAuthAndParse() {
        var parameters: Parameters? {
            return [
                "username": "dsfsfs",
                "password": "password"
            ]
        }
        
        AF
            .request("https://afternoon-ravine-72981.herokuapp.com/auth", method: .post, parameters: parameters)
            .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<LoginResult>) in
                switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
                self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testExitAndParse() {
        var parameters: Parameters? {
            return [
                "id_user": 123
            ]
        }
        
        AF
            .request("https://afternoon-ravine-72981.herokuapp.com/logout", method: .post, parameters: parameters)
            .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<LogoutResult>) in
                switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
                self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRegisterUserAndParse() {
        var parameters: Parameters? {
            return [
                "id_user": 123,
                "username": "login",
                "password": "password",
                "email": "email",
                "gender": "m",
                "credit_card": "creditCard",
                "bio": "bio"
            ]
        }
        
        AF
            .request("https://afternoon-ravine-72981.herokuapp.com/register", method: .post, parameters: parameters)
            .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<RegisterResult>) in
                switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
                self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testChangeUserDataAndParse() {
        var parameters: Parameters? {
            return [
                "id_user": 123,
                "username": "login",
                "password": "password",
                "email": "email",
                "gender": "m",
                "credit_card": "creditCard",
                "bio": "bio"
            ]
        }
        
        AF
            .request("https://afternoon-ravine-72981.herokuapp.com/changeUserData", method: .post, parameters: parameters)
            .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<ChangeUserDataResult>) in
                switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
                self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testProductAndParse() {
        var parameters: Parameters? {
            return [
                "id_product": 123
            ]
        }
        
        AF
            .request("https://afternoon-ravine-72981.herokuapp.com/getGoodById", method: .post, parameters: parameters)
            .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<ProductResult>) in
                switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
                self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCatalogAndParse() {
        var parameters: Parameters? {
            return [
                "page_number": 1,
                "id_category": 1
            ]
        }
        
        AF
            .request("https://afternoon-ravine-72981.herokuapp.com/catalogData", method: .post, parameters: parameters)
            .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<CatalogResult>) in
                switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
                self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
