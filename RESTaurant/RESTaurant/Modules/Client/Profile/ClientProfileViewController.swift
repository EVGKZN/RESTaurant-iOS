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
    }
}
