//
//  LoginViewController.swift
//  RecipeBox
//
//  Login Controller
//
//  Created by Reshma Unnikrishnan on 21.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Public Properties
    
    var loginViewModel: LoginViewModel = LoginViewModel()

    // MARK: - Initializations
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegates()
    }
    
    // MARK: - Delegates
    
    /// Login button Delegate
    @IBAction func didTapLoginButton(_ sender: Any) {
        loginViewModel.setLoginWith(userName: username.text ?? " ", password: password.text ?? " ")
    }
    
    /// Textfield delegate for resign first responder
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let validateEmail = loginViewModel.validateEmail(username.text ?? "")
        let validatePassword = loginViewModel.validatePassword(password.text ?? "")
        
        if (validateEmail && validatePassword) {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        } else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
        }
        
        return true
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        return true;
    }
    
    // MARK: - Private functions
    
    /// UI set up routines
    private func setupUI() {
        username.rounded()
        password.rounded()
        loginButton.rounded()
        
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
    }
    
    /// Delegate Seup routines
    private func setupDelegates() {
        loginViewModel.delegate = self
        username.delegate = self
        password.delegate = self
    }
}

/// Login View Controller delegate implementation
extension LoginViewController: LoginViewModelDelegate {
    func showAlert(withMessage: String) {
        // Nothing to do
    }
    
    /// Login was successfull callback
    ///
    /// navigate to the main view controller after login
    func loginWasSuccessful() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let recipeVC = storyBoard.instantiateViewController(withIdentifier: "Recipes") as! RecipeTableViewController
        self.navigationController?.pushViewController(recipeVC, animated: true)
    }
}
