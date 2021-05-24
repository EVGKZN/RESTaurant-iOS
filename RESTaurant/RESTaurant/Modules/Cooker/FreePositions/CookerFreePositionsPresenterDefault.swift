//
//  CookerFreePositionsPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import Foundation
import Moya

class CookerFreePositionsPresenterDefault: CookerFreePositionsPresenter {

    private weak var view: CookerFreePositionsView?
    private let positionsProvider = MoyaProvider<PositionTarget>()

    func attachView(view: CookerFreePositionsView) {
        self.view = view
    }

    func loadFreePositions() {
        positionsProvider.request(.getPositionsByStatus(status: "CREATED")) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let positionsResponse = try JSONDecoder().decode([PositionResponse].self, from: response.data)
                    self?.view?.showFreePositions(positions: positionsResponse)
                } catch {
                    self?.view?.showErrorAlert()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }

    func addPositionToMyPositions(positionID: Int) {
        positionsProvider.request(.changePositionStatus(positionID: positionID, status: "COOKING")) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    self?.loadFreePositions()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }
}
