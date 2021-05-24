//
//  PositionTarget.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Moya

public enum PositionTarget {
    case changePositionStatus(positionID: Int, status: String)
    case addPositionByDishIdToOrder(dishID: Int, orderID: String)
}

extension PositionTarget: TargetType {

    public var baseURL: URL {
      return URL(string: "https://restaurantteam404.herokuapp.com")!
    }

    public var path: String {
        switch self {
        case .changePositionStatus:
            return "/api/position/status"
        case .addPositionByDishIdToOrder:
            return "/api/position"
        }
    }

    public var method: Method {
        switch self {
        case .changePositionStatus, .addPositionByDishIdToOrder:
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
        case .addPositionByDishIdToOrder(let dishID, let orderID):
            return .requestJSONEncodable(AddRequest(dish: Dish(id: dishID), orderId: orderID))
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

private struct Dish: Codable {
    let id: Int
}

private struct AddRequest: Codable {
    let dish: Dish
    let orderId: String
}
