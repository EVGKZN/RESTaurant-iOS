//
//  TableTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import Moya

public enum TableTarget {
    case reserveTable(tableID: String)
}

extension TableTarget: TargetType {
    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .reserveTable:
            return "/api/table/reserve"
        }
    }

    public var method: Method {
        switch self {
        case .reserveTable:
            return .post
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .reserveTable(let tableID):
            return .requestParameters(parameters: ["id" : tableID], encoding: JSONEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
