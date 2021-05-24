//
//  PositionTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Moya

public enum PositionTarget {
    case changePositionStatus(positionID: Int, status: String)
}

extension PositionTarget: TargetType {

    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .changePositionStatus:
            return "/api/position/status"
        }
    }

    public var method: Method {
        switch self {
        case .changePositionStatus:
            return .post
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .changePositionStatus(let positionID, let positionStatus):
            return .requestParameters(parameters: ["id" : positionID, "status" : positionStatus], encoding: JSONEncoding.default)
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
