//
//  WaiterTabBarController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class WaiterTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = .white
        let myOrdersViewController = instantiateViewController(identifier: "WaiterMyOrdersNavigationController", imageName: "myOrdersGray", selectedImageName: "myOrdersBlue")
        let freeOrdersViewController = instantiateViewController(identifier: "WaiterFreeOrdersViewController", imageName: "freeOrdersGray", selectedImageName: "freeOrdersBlue")
        let profileViewController = instantiateViewController(identifier: "WaiterProfileViewController", imageName: "profileGray", selectedImageName: "profileBlue")
        viewControllers = [myOrdersViewController, freeOrdersViewController, profileViewController]
    }
}
