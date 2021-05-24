//
//  WaiterFreeOrdersModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation

protocol WaiterFreeOrdersView: AnyObject {
    func showErrorAlert()
    func presentFreeOrders(orders: [OrderResponse])
}

protocol WaiterFreeOrdersPresenter: AnyObject {
    func takeOrder(orderID: String)
    func attachView(view: WaiterFreeOrdersView)
    func loadFreeOrders()
}

