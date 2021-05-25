//
//  OrderTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import Moya

public enum OrderTarget {
    case getOrderByTableID(tableID: String)
    case getOrderByStatus(status: String)
    case takeOrderByID(orderID: String)
    case getOrderByID(orderID: String)
    case getWaiterActiveOrders
    case closeOrder(orderID: String)
}

extension OrderTarget: TargetType {
    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .getOrderByTableID:
            return "/api/order/table"
        case .getOrderByStatus:
            return "/api/order"
        case .takeOrderByID:
            return "/api/order/take"
        case .getWaiterActiveOrders:
            return "/api/order/my"
        case .getOrderByID(let orderID):
            return "/api/order/\(orderID)"
        case .closeOrder:
            return "/api/order/close"
        }
    }

    public var method: Method {
        switch self {
        case .getOrderByTableID, .getOrderByStatus, .getWaiterActiveOrders, .getOrderByID:
            return .get
        case .takeOrderByID, .closeOrder:
            return .post
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .getOrderByTableID(let tableID):
            return .requestParameters(parameters: ["tableId" : tableID], encoding: URLEncoding.queryString)
        case .getOrderByStatus(let status):
            return .requestParameters(parameters: ["status" : status], encoding: URLEncoding.queryString)
        case .takeOrderByID(let orderID):
            return .requestParameters(parameters: ["id" : orderID], encoding: JSONEncoding.default)
        case .getWaiterActiveOrders, .getOrderByID:
            return .requestPlain
        case .closeOrder(let orderID):
            return .requestParameters(parameters: ["id" : orderID], encoding: JSONEncoding.default)
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
