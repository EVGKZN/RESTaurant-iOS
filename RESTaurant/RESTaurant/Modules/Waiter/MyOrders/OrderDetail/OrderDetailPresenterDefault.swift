//
//  OrderDetailPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation
import Moya

class OrderDetailPresenterDefault: OrderDetailPresenter {

    private weak var view: OrderDetailView?
    private let orderProvider = MoyaProvider<OrderTarget>()
    private let positionProvider = MoyaProvider<PositionTarget>()

    func attachView(view: OrderDetailView) {
        self.view = view
    }

    func loadOrder(orderID: String) {
        orderProvider.request(.getOrderByID(orderID: orderID)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let orderResponse = try JSONDecoder().decode(OrderResponse.self, from: response.data)
                    self?.view?.showOrder(order: orderResponse)
                } catch {
                    self?.view?.showErrorAlert()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }

    func servePosition(positionID: Int, positionStatus: String) {
        positionProvider.request(.changePositionStatus(positionID: positionID, status: positionStatus)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    self?.view?.positionSuccessfulServed()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }
}
