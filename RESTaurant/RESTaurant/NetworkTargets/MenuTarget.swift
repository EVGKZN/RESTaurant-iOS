//
//  MenuTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Moya

public enum MenuTarget {
    case getMenusByRestaurantID(restaurantID: String)
}

extension MenuTarget: TargetType {

    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .getMenusByRestaurantID:
            return "/api/menus"
        }
    }

    public var method: Method {
        switch self {
        case .getMenusByRestaurantID:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .getMenusByRestaurantID(let restaurantID):
            return .requestParameters(parameters: ["restaurantId" : restaurantID], encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        var token = ""
        if let authorizationResponse = UserDefaultsHelper.getCurrentAuthorizationInfo() {
            token = authorizationResponse.token
        }
        return ["Authorization":token]
    }
}
