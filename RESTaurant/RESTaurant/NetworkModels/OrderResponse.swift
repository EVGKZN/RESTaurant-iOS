//
//  OrderResponse.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import Foundation

struct OrderResponse: Decodable {
    let id: String
    let table: TableResponse
    let restaurant: RestaurantResponse
    let positions: [PositionResponse]
    let employee: EmployeeResponse?
    let status: String
}

struct TableResponse: Decodable {
    let id: String
    let seatCount: Int
    let restaurant: RestaurantResponse
    let status: String
}

struct RestaurantResponse: Decodable {
    let id: String
    let name: String
    let location: String
}

struct PositionResponse: Decodable {
    let id: Int
    let dish: DishResponse
    let cook: EmployeeResponse?
    let status: String
}

struct DishResponse: Decodable {
    let id: Int
    let menu: MenuResponse
    let dishType: String
    let name: String
    let cost: Int
    let description: String
    let composition: String
    let weight: Int
}

struct MenuResponse: Decodable {
    let id: Int
    let name: String
    let restaurant: RestaurantResponse
}

struct EmployeeResponse: Decodable {
    let id: String
    let account: AccountResponse
    let firstName: String
    let lastName: String
    let fatherName: String
    let phoneNumber: String
    let role: String
    let restaurant: RestaurantResponse
}

struct AccountResponse: Decodable {
    let id: Int
    let email: String
    let role: String
}

