//
//  MenuModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation

protocol MenuView: AnyObject {
    func showErrorAlert()
}

protocol MenuPresenter: AnyObject {
    func attachView(view: MenuView)
    func loadMenu()
}
