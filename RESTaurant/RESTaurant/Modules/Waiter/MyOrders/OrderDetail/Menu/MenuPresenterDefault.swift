//
//  MenuPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation
import Moya

class MenuPresenterDefault: MenuPresenter {

    private weak var view: MenuView?
    private let menuProvider = MoyaProvider<MenuTarget>()
    private let dishProvider = MoyaProvider<DishTarget>()
    private let positionProvider = MoyaProvider<PositionTarget>()

    func attachView(view: MenuView) {
        self.view = view
    }

    func loadMenu(restaurantID: String) {
        menuProvider.request(.getMenusByRestaurantID(restaurantID: restaurantID)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let menusResponse = try JSONDecoder().decode([MenuResponse].self, from: response.data)
                    for menu in menusResponse {
                        self?.dishProvider.request(.getDishesByMenuID(menuID: menu.id)) { [weak self] (result) in
                            switch result {
                            case let .success(response):
                                do {
                                    print(response)
                                    let dishesResponse = try JSONDecoder().decode([DishResponse].self, from: response.data)
                                    self?.view?.addDishesToMenu(dishes: dishesResponse)
                                    if menusResponse.last?.id == menu.id {
                                        self?.view?.reloadData()
                                    }
                                } catch {
                                    self?.view?.showErrorAlert()
                                }
                            case let .failure(error):
                                print(error)
                                self?.view?.showErrorAlert()
                            }
                        }
                    }
                } catch {
                    self?.view?.showErrorAlert()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }

    func addDishToOrder(dishID: Int, orderID: String) {
        positionProvider.request(.addPositionByDishIdToOrder(dishID: dishID, orderID: orderID)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    self?.view?.performSuccessfulAddingDishToOrder()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }
}
