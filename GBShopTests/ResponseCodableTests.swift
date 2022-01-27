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
    let expectation = XCTestExpectation(description: "Download https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")
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
        AF
            .request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/login.json")
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
        AF
            .request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/logout.json")
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
        AF
            .request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/registerUser.json")
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
        AF
            .request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/changeUserData.json")
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
        AF
            .request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/getGoodById.json")
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
        AF
            .request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/catalogData.json")
            .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<[ProductResult]>) in
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
