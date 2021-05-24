//
//  CookerViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class CookerTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = .white
        let myPositionsViewController = instantiateViewController(identifier: "CookerMyPositionsViewController", imageName: "myPositionsGray", selectedImageName: "myPositionsBlue")
        let freePositionsViewController = instantiateViewController(identifier: "CookerFreePositionsViewController", imageName: "freeOrdersGray", selectedImageName: "freeOrdersBlue")
        let profileViewController = instantiateViewController(identifier: "CookerProfileViewController", imageName: "profileGray", selectedImageName: "profileBlue")
        viewControllers = [myPositionsViewController, freePositionsViewController, profileViewController]
    }
}
