//
//  AuthorizationViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import UIKit

class AuthorizationViewController: BaseViewController {

    private class Constants: GlobalConstants {
        static let emailTextFieldPlaceholderText = "Email"
        static let passwordTextFieldPlaceholderText = "Пароль"
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var authorizeButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    private var presenter: AuthorizationPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = AuthorizationPresenterDefault(view: self)
        hideKeyboardWhenTappedAround()
        setupNavigationController()
        setupTextFieldsPlaceholders()
    }

    private func setupTextFieldsPlaceholders() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.attributedPlaceholder = NSAttributedString(string: Constants.emailTextFieldPlaceholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: Constants.passwordTextFieldPlaceholderText, attributes:
                                                                        [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.textContentType = .emailAddress
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
    }

    private func setupNavigationController() {
        self.navigationController?.navigationBar.tintColor = Constants.brandBlueColor
    }

    @IBAction func forgotPasswordButtonDidPress(_ sender: Any) {
        presentAlert(withTitle: "Ошибка", message: "Функционал в разработке")
    }

    @IBAction func authorizeButtonDidPress(_ sender: Any) {
        view.endEditing(true)
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty
        else {
            presentAlert(withTitle: "Введены некорректные данные", message: "Попробуйте снова")
            return
        }
        authorizeButton.isUserInteractionEnabled = false
        showActivityIndicatorView()
        presenter.performAuthorization(email: email, password: password)
    }

    @IBAction func signUpButtonDidPress(_ sender: Any) {
        presentAlert(withTitle: "Ошибка", message: "Функционал в разработке")
    }

    private func endLoading() {
        hideActivityIndicatorView()
        authorizeButton.isUserInteractionEnabled = true
    }
}

extension AuthorizationViewController: AuthorizationView {
    func presentFailure(message: String) {
        endLoading()
        presentAlert(withTitle: "Внутренняя ошибка приложения", message: "Сообщение: \(message)")
    }

    func presentNetworkFailure(errorCode: Int) {
        endLoading()
        presentAlert(withTitle: "Ошибка сервера", message: "Код ошибки: \(errorCode)")
    }

    func presentSuccess(response: AuthorizationResponse) {
        endLoading()
        presentAlert(withTitle: "Успешно", message: "Токен: \(response.token)")
    }
}
