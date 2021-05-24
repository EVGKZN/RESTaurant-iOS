//
//  ClientProfileViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import UIKit

class ClientProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func techButtonPressed(_ sender: Any) {
        UserDefaultsHelper.setCurrentTableID(tableID: nil)
        let alertController = UIAlertController(title: "Вы покинули заказ", message: "Чтобы снова подключиться к заказу, просканируйте QR-код", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "ОК", style: .default) { _ in
            let storyboard = UIStoryboard(name: GlobalConstants.storyboardMainName, bundle: nil)
            let clientWorflowVc = storyboard.instantiateViewController(identifier: GlobalConstants.viewControllerMainMenuNavigationController)
            UIApplication.shared.windows.first?.rootViewController = clientWorflowVc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
