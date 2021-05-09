//
//  ViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 21.02.2021.
//

import UIKit

class MainMenuViewController: UIViewController {

    private class Constants: GlobalConstants {
        static let authorizationViewSegueIdentifier: String = "toAuthorizationSegue"
        static let qrCodeScannerViewSegueIdentifier: String = "toQRCodeScannerSegue"
    }

    @IBOutlet weak var scanQRCodeButton: UIButton!
    @IBOutlet weak var authorizationButton: UIButton!
    
    @IBAction func scanQRCodeButtonDidPress(_ sender: Any) {
        performSegue(withIdentifier: Constants.qrCodeScannerViewSegueIdentifier, sender: nil)
    }

    @IBAction func authorizationButtonDidPress(_ sender: Any) {
        performSegue(withIdentifier: Constants.authorizationViewSegueIdentifier, sender: nil)
    }
}

