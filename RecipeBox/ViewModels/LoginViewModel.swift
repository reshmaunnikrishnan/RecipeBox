//
//  LoginViewModel.swift
//  RecipeBox
//
//  Created by Reshma Unnikrishnan on 27.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    
    //informs the delegate to show an alert that either the
    //username or password have  failed the conditions
    func showAlert(withMessage: String)
    
    //informs the delegate that the user passed the login successfully
    func loginWasSuccessful()
}

class LoginViewModel {
    
    // MARK: - Public Properties
    
    weak var delegate: LoginViewModelDelegate?
    let apiService: NetworkServiceProtocol
    
    init(apiService: NetworkServiceProtocol = NetworkService()) {
        self.apiService = apiService
    }
    
    // MARK: - Public Methods
    
    /// Login call and api validation
    func setLoginWith(userName: String, password: String) {
        let endpoint = APIEndPoint.user(login: "reshma: password")
        let requestData = RequestData(path: endpoint.path, method: .post, params: [:], headers: [:])
        
        apiService.execute(request: requestData, onSuccess: { (loginResponse) in
            print(loginResponse)
            self.delegate?.loginWasSuccessful()
        }) { (error) in
            print(error)
        
            self.delegate?.loginWasSuccessful()
        }
    }
    
    /// Email address validator
    func validateEmail(_ username : String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let validationStatus = NSPredicate(format:"SELF MATCHES %@", regEx)
        if (validationStatus.evaluate(with: username) == false) {
            //Handle error case
            return false
        }
        return true
    }
    
    /// Password validator
    func validatePassword(_ password: String) -> Bool {
        if password.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
}
