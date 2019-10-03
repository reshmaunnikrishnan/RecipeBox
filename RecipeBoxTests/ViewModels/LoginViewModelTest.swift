//
//  NetworkServiceTest.swift
//  RecipeBoxTests
//
//  Created by Reshma Unnikrishnan on 29.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import XCTest
import RecipeBox

class LoginViewModelTest: XCTestCase {
    var mockService: MockNetworkService! = nil
    var mockLoginViewModelDelegate: MockLoginViewModelDelegate! = nil
    var sut: LoginViewModel! = nil
    
    override func setUp() {
        super.setUp()
        
        mockService = MockNetworkService()
        mockLoginViewModelDelegate = MockLoginViewModelDelegate()
        sut = LoginViewModel(apiService: mockService)
        sut.delegate = mockLoginViewModelDelegate
    }

    override func tearDown() {
        super.tearDown()
        
        mockService = nil
        mockLoginViewModelDelegate = nil
        sut.delegate = nil
    }

    // MARK: - setLoginWith tests
    
    func testShouldCallDelegateLoginSuccessfull() {
       
        let expectation = XCTestExpectation(description: "Login Successfull")
        
        mockLoginViewModelDelegate.expectation = expectation
        sut.setLoginWith(userName: "test", password: "test")
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testShouldCallDelegateLoginSuccessfullOnError() {
        
        let mockService = MockNetworkErrorService()
        let mockLoginViewModelDelegate = MockLoginViewModelDelegate()
        
        let sut = LoginViewModel(apiService: mockService)
        sut.delegate = mockLoginViewModelDelegate
        
        let expectation = XCTestExpectation(description: "Login Successfull")
        
        mockLoginViewModelDelegate.expectation = expectation
        
        sut.setLoginWith(userName: "test", password: "test")
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - validateEmail tests
    
    func testEmailStringShouldValidateFalse() {
        let result = sut.validateEmail("valdu23efkef")
        XCTAssertEqual(result, false)
    }

    func testEmailStringShouldValidateTrue() {
        let result = sut.validateEmail("person@hellofresh.com")
        XCTAssertEqual(result, true)
    }
    
    //MARK: - validatePassword tests
    
    func testPasswordStringShouldValidateFalse() {
        let result = sut.validatePassword("abcd")
        XCTAssertEqual(result, false)
    }
    
    func testPasswordStringShouldValidateTrue() {
        let result = sut.validatePassword("abcdefghi")
        XCTAssertEqual(result, true)
    }
    
    func testPerformanceExample() {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


class MockLoginViewModelDelegate: LoginViewModelDelegate {
    var expectation: XCTestExpectation? = nil
    
    func showAlert(withMessage: String) {
        // Nothing to do
    }
    
    func loginWasSuccessful() {
        expectation?.fulfill()
    }
}

class MockNetworkService : NetworkServiceProtocol {
    func execute(request: RequestData, onSuccess: @escaping (AnyObject) -> Void, onError: @escaping (Error) -> Void) {
        onSuccess(true as AnyObject)
    }
}

class MockNetworkErrorService : NetworkServiceProtocol {
    func execute(request: RequestData, onSuccess: @escaping (AnyObject) -> Void, onError: @escaping (Error) -> Void) {
        onError(ResponseError.noData)
    }
}
