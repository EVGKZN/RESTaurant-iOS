//
//  AuthorizationViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import UIKit

class AuthorizationViewController: UIViewController {

    private class Constants: GlobalConstants {
        static let emailTextFieldPlaceholderText = "Email"
        static let passwordTextFieldPlaceholderText = "Пароль"
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var authorizeButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setupNavigationController()
        setupTextFieldsPlaceholders()
    }

    private func setupTextFieldsPlaceholders() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.attributedPlaceholder = NSAttributedString(string: Constants.emailTextFieldPlaceholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: Constants.passwordTextFieldPlaceholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.isSecureTextEntry = true
    }

    private func setupNavigationController() {
        self.navigationController?.navigationBar.tintColor = Constants.brandBlueColor
    }

    @IBAction func forgotPasswordButtonDidPress(_ sender: Any) {

    }

    @IBAction func authorizeButtonDidPress(_ sender: Any) {

    }

    @IBAction func signUpButtonDidPress(_ sender: Any) {

    }
}
