//
//  CookerMyPositionsModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import Foundation

protocol CookerMyPositionsView: AnyObject {
    func showErrorAlert()
    func showMyPositions(positions: [PositionResponse])
}

protocol CookerMyPositionsPresenter: AnyObject {
    func attachView(view: CookerMyPositionsView)
    func loadMyPositions()
    func markPositionAsCooked(positionID: Int)
}
