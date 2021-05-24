//
//  CookerFreePositionsModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import Foundation

protocol CookerFreePositionsView: AnyObject {
    func showErrorAlert()
    func showFreePositions(positions: [PositionResponse])
}

protocol CookerFreePositionsPresenter: AnyObject {
    func attachView(view: CookerFreePositionsView)
    func loadFreePositions()
    func addPositionToMyPositions(positionID: Int)
}
