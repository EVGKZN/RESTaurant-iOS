//
//  AuthorizationPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import Foundation
import Moya
import Alamofire

class AuthorizationPresenterDefault: AuthorizationPresenter {
    private weak var view: AuthorizationView?
    private let authorizationProvider = MoyaProvider<AuthorizationTarget>()
    private let employeeProvider = MoyaProvider<EmployeeTarget>()

    required init(view: AuthorizationView) {
        self.view = view
    }

    func performAuthorization(email: String, password: String) {
        authorizationProvider.request(.signIn(email: email, password: password)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let authResponse = try JSONDecoder().decode(AuthorizationResponse.self, from: response.data)
                    UserDefaultsHelper.setCurrentAuthorizationInfo(accountInfo: authResponse)
                    self?.employeeProvider.request(.getCurrentEmployee) { [weak self] (result) in
                        switch result {
                        case let .success(response):
                            do {
                                print(response)
                                let employeeResponse = try JSONDecoder().decode(EmployeeResponse.self, from: response.data)
                                UserDefaultsHelper.setCurrentEmployeeInfo(employeeInfo: employeeResponse)
                                self?.view?.performSuccessfulAuthorization(response: employeeResponse)
                            } catch {
                                UserDefaultsHelper.setCurrentAuthorizationInfo(accountInfo: nil)
                            }
                        case let .failure(error):
                            print(error)
                            UserDefaultsHelper.setCurrentAuthorizationInfo(accountInfo: nil)
                        }
                    }
                } catch {
                    self?.view?.presentNetworkFailure(errorCode: response.statusCode)
                }
            case let .failure(error):
                print(error)
                self?.view?.presentFailure(message: error.localizedDescription)
            }
        }
    }
}
