//
//  AuthorizationResponse.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import Foundation

struct AuthorizationResponse: Codable {
    let token: String
    let account: AccountResponse
}
