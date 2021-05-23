//
//  OrderTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import Moya

public enum OrderTarget {
    case getOrderByTableID(tableID: String)
}

extension OrderTarget: TargetType {
    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .getOrderByTableID:
            return "/api/order/table"
        }
    }

    public var method: Method {
        switch self {
        case .getOrderByTableID:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .getOrderByTableID(let tableID):
            return .requestParameters(parameters: ["tableId" : tableID], encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        return [:]
    }
}
