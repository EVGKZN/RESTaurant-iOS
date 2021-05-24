//
//  AuthorizationModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import Foundation

protocol AuthorizationView: AnyObject {
    func presentNetworkFailure(errorCode: Int)
    func presentFailure(message: String)
    func performSuccessfulAuthorization(response: EmployeeResponse)
}

protocol AuthorizationPresenter: AnyObject {
    func performAuthorization(email: String, password: String)
}
