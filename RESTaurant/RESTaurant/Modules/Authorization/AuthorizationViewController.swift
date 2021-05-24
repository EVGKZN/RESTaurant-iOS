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


    // ДОБАВЛЕНО ДЛЯ УДОБСТВА ТЕСТИРОВАНИЯ

    @IBAction func setWaiterAuthData(_ sender: Any) {
        emailTextField.text = "VOBuzanov@gmail.com"
        passwordTextField.text = "123"
    }

    @IBAction func setCookerAuthData(_ sender: Any) {
        emailTextField.text = "VOBuzanov234@gmail.com"
        passwordTextField.text = "123"
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

    func performSuccessfulAuthorization(response: EmployeeResponse) {
        endLoading()
        switch response.role {
        case "WAITER":
            let storyboard = UIStoryboard(name: GlobalConstants.storyboardWaiterWorkflowName, bundle: nil)
            let waiterWorflowVc = storyboard.instantiateViewController(identifier: GlobalConstants.viewControllerWaiterTabBarName)
            UIApplication.shared.windows.first?.rootViewController = waiterWorflowVc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        case "COOK":
            //TODO: Dodelats
        return
        default:
            presentAlert(withTitle: "Ошибка", message: "Функционал в разработке")
        }
    }
}
