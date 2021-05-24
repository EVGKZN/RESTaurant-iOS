//
//  WaiterFreeOrdersPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation
import Moya

class WaiterFreeOrdersPresenterDefault: WaiterFreeOrdersPresenter {

    private weak var view: WaiterFreeOrdersView?
    private let orderProvider = MoyaProvider<OrderTarget>()

    func attachView(view: WaiterFreeOrdersView) {
        self.view = view
    }

    func loadFreeOrders() {
        orderProvider.request(.getOrderByStatus(status: "CREATED")) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let ordersReponse = try JSONDecoder().decode([OrderResponse].self, from: response.data)
                    self?.view?.presentFreeOrders(orders: ordersReponse)
                } catch {
                    self?.view?.showErrorAlert()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }

    func takeOrder(orderID: String) {
        orderProvider.request(.takeOrderByID(orderID: orderID)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    self?.loadFreeOrders()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }
    
}
