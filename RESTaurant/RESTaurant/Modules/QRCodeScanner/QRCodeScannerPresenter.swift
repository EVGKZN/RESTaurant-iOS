//
//  QRCodeScannerPresenter.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import UIKit
import Moya

class QRCodeScannerPresenterDefault: QRCodeScannerPresenter {

    private class Constants: GlobalConstants {
        static let checkString: String = "http://restaurant404.tilda.ws?tableId="
    }

    private weak var view: QRCodeScannerView?
    private let tableProvider = MoyaProvider<TableTarget>()

    func attachView(view: QRCodeScannerView) {
        self.view = view
    }

    func checkQRCodeScanningResult(result: String) {
        if result.contains(Constants.checkString) {
            let tableID = result.replacingOccurrences(of: Constants.checkString, with: "")
            print(tableID)
            tableProvider.request(.reserveTable(tableID: tableID)) { [weak self] (result) in
                switch result {
                case let .success(response):
                    do {
                        print(response)
                        UserDefaults.standard.set(tableID, forKey: Constants.userDefaultsCurrentTableIDKey)
                        self?.view?.performSuccessfulTableReserving()
                    }
                case let .failure(error):
                    print(error)
                    self?.view?.showErrorAlert()
                }
            }
        } else {
            view?.showErrorAlert()
        }
    }


}
