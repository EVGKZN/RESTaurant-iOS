//
//  QRCodeScannerModule.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import Foundation

protocol QRCodeScannerView: AnyObject {
    func qrScanningDidFail()
    func performSuccessfulTableReserving()
    func showErrorAlert()
}

protocol QRCodeScannerPresenter: AnyObject{
    func attachView(view: QRCodeScannerView)
    func checkQRCodeScanningResult(result: String)
}
