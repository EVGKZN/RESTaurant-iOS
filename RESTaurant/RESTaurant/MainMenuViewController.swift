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

    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentEmployeeInfo = UserDefaultsHelper.getCurrentEmployeeInfo() {
            switch currentEmployeeInfo.role {
            case "WAITER":
                let storyboard = UIStoryboard(name: GlobalConstants.storyboardWaiterWorkflowName, bundle: nil)
                let waiterWorflowVc = storyboard.instantiateViewController(identifier: GlobalConstants.viewControllerWaiterTabBarName)
                UIApplication.shared.windows.first?.rootViewController = waiterWorflowVc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            case "COOK":
                //TODO: Dodelats
                break
            default:
                break
            }
        } else if let tableID = UserDefaultsHelper.getCurrentTableID() {
            print(tableID)
            let storyboard = UIStoryboard(name: GlobalConstants.storyboardClientWorkflowName, bundle: nil)
            let clientWorflowVc = storyboard.instantiateViewController(identifier: GlobalConstants.viewControllerClientTabBarName)
            UIApplication.shared.windows.first?.rootViewController = clientWorflowVc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}

