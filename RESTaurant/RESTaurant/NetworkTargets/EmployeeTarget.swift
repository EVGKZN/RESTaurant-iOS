//
//  EmployeeTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Moya

public enum EmployeeTarget {
    case getCurrentEmployee
}

extension EmployeeTarget: TargetType {
    
    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .getCurrentEmployee:
            return "/api/employee/current"
        }
    }

    public var method: Method {
        switch self {
        case .getCurrentEmployee:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .getCurrentEmployee:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        var token = ""
        if let authorizationResponse = UserDefaultsHelper.getCurrentAuthorizationInfo() {
            token = authorizationResponse.token
        }
        return ["Accept":"application/json","Authorization":token]
    }
}
