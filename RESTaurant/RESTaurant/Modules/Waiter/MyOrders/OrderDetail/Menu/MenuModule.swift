//
//  MenuModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation

protocol MenuView: AnyObject {
    func showErrorAlert()
    func addDishesToMenu(dishes: [DishResponse])
    func reloadData()
    func performSuccessfulAddingDishToOrder()
}

protocol MenuPresenter: AnyObject {
    func attachView(view: MenuView)
    func loadMenu(restaurantID: String)
    func addDishToOrder(dishID: Int, orderID: String)
}
