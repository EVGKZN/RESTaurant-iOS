//
//  QRCodeScannerViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import UIKit

class QRCodeScannerViewController: UIViewController {

    private class Constants: GlobalConstants { }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
    }

    private func setupNavigationController() {
        self.navigationController?.navigationBar.tintColor = Constants.brandWhiteColor
    }
}
