//
//  ClientCurrentOrderModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import Foundation

protocol ClientCurrentOrderView: AnyObject {
    func showOrderInfo(info: OrderResponse)
    func presentNetworkFailure(errorCode: Int)
    func presentFailure(message: String)
}

protocol ClientCurrentOrderPresenter: AnyObject {
    func attachView(view: ClientCurrentOrderView)
    func loadOrderInfo()
}
