//
//  OrderDetailModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation

protocol OrderDetailView: AnyObject {
    func showErrorAlert()
    func showOrder(order: OrderResponse)
    func positionSuccessfulServed()
    func performSuccessfulOrderdClosing()
}

protocol OrderDetailPresenter: AnyObject {
    func attachView(view: OrderDetailView)
    func loadOrder(orderID: String)
    func servePosition(positionID: Int, positionStatus: String)
    func closeOrder(orderID: String)
}
