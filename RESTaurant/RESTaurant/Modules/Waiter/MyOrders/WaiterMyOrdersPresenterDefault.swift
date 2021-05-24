//
//  WaiterMyOrdersPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation
import Moya

class WaiterMyOrdersPresenterDefault: WaiterMyOrdersPresenter {

    private weak var view: WaiterMyOrdersView?
    private let orderProvider = MoyaProvider<OrderTarget>()

    func attachView(view: WaiterMyOrdersView) {
        self.view = view
    }

    func loadMyOrders() {
        orderProvider.request(.getWaiterActiveOrders) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let ordersResponse = try JSONDecoder().decode([OrderResponse].self, from: response.data)
                    self?.view?.showMyOrders(orders: ordersResponse)
                } catch {
                    self?.view?.showErrorAlert()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }
}
