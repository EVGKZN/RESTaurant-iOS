//
//  DishTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Moya

public enum DishTarget {
    case getDishesByMenuID(menuID: Int)
}

extension DishTarget: TargetType {

    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .getDishesByMenuID:
            return "/api/dish"
        }
    }

    public var method: Method {
        switch self {
        case .getDishesByMenuID:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .getDishesByMenuID(let menuID):
            return .requestParameters(parameters: ["menuId" : menuID], encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        var token = ""
        if let authorizationResponse = UserDefaultsHelper.getCurrentAuthorizationInfo() {
            token = authorizationResponse.token
        }
        return ["Authorization":token]
    }

    public var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
