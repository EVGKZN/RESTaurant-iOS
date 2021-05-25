//
//  CookerMyPositionsPresenterDefault.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import Foundation
import Moya

class CookerMyPositionsPresenterDefault: CookerMyPositionsPresenter {

    private weak var view: CookerMyPositionsView?
    private let positionsProvider = MoyaProvider<PositionTarget>()

    func attachView(view: CookerMyPositionsView) {
        self.view = view
    }

    func loadMyPositions() {
        positionsProvider.request(.getMyPositions) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let positionsResponse = try JSONDecoder().decode([PositionResponse].self, from: response.data)
                    self?.view?.showMyPositions(positions: positionsResponse)
                } catch {
                    self?.view?.showErrorAlert()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }

    func markPositionAsCooked(positionID: Int) {
        positionsProvider.request(.changePositionStatus(positionID: positionID, status: "COOKED")) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    self?.loadMyPositions()
                }
            case let .failure(error):
                print(error)
                self?.view?.showErrorAlert()
            }
        }
    }
}
