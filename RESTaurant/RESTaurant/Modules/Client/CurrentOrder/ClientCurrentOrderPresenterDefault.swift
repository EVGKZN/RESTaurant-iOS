//
//  ClientCurrentOrderPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import Moya

class ClientCurrentOrderPresenterDefault: ClientCurrentOrderPresenter {

    private weak var view: ClientCurrentOrderView?
    private let orderProvider = MoyaProvider<OrderTarget>()

    func attachView(view: ClientCurrentOrderView) {
        self.view = view
    }

    func loadOrderInfo() {
        guard let tableID = UserDefaultsHelper.getCurrentTableID() else { return }
        orderProvider.request(.getOrderByTableID(tableID: tableID)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let orderResponse = try JSONDecoder().decode(OrderResponse.self, from: response.data)
                    self?.view?.showOrderInfo(info: orderResponse)
                } catch {
                    self?.view?.showErrorAlert()
                }
            case let .failure(error):
                print(error)
                self?.view?.showClosedOrderAlert()
            }
        }
    }
}
