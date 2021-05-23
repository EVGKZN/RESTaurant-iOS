//
//  AuthorizationPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import Foundation
import Moya

class AuthorizationPresenterDefault: AuthorizationPresenter {
    private weak var view: AuthorizationView?
    private let authorizationProvider = MoyaProvider<AuthorizationTarget>()

    required init(view: AuthorizationView) {
        self.view = view
    }

    func performAuthorization(email: String, password: String) {
        print("EMAIL : \(email), PASSWORD : \(password)")
        authorizationProvider.request(.signIn(email: email, password: password)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let authResponse = try JSONDecoder().decode(AuthorizationResponse.self, from: response.data)
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(authResponse) {
                        UserDefaults.standard.set(encoded, forKey: GlobalConstants.userDefaultsCurrentAccountInfoIDKey)
                    }
                    self?.view?.presentSuccess(response: authResponse)
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
