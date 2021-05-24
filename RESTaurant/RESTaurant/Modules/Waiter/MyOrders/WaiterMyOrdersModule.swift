//
//  WaiterMyOrdersModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation

protocol WaiterMyOrdersView: AnyObject {
    func showErrorAlert()
    func showMyOrders(orders: [OrderResponse])
}

protocol WaiterMyOrdersPresenter: AnyObject {
    func attachView(view: WaiterMyOrdersView)
    func loadMyOrders()
}
