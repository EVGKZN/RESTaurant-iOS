//
//  AuthorizationTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import Moya

public enum AuthorizationTarget {
    case signIn(email: String, password: String)
}

extension AuthorizationTarget: TargetType {
    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .signIn:
            return "/api/signIn"
        }
    }

    public var method: Method {
        switch self {
        case .signIn:
            return .post
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .signIn(let email, let password):
            return .requestParameters(parameters: ["email" : email, "password" : password], encoding: JSONEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
