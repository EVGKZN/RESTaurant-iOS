//
//  ClientTabBarViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import UIKit

class ClientTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = .white
        let orderHistoryViewController = instantiateViewController(identifier: "ClientOrderHistoryViewController", imageName: "orderHistoryGray", selectedImageName: "orderHistoryBlue")
        let currentOrderViewController = instantiateViewController(identifier: "ClientCurrentOrderViewController", imageName: "currentOrderGray", selectedImageName: "currentOrderBlue")
        let profileViewController = instantiateViewController(identifier: "ClientProfileViewController", imageName: "profileGray", selectedImageName: "profileBlue")
        viewControllers = [orderHistoryViewController, currentOrderViewController, profileViewController]
        selectedIndex = 1
    }
}
