//
//  ClientTabBarViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import UIKit

class ClientTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = .white
        let orderHistoryViewController = instantiateViewController(identifier: "ClientOrderHistoryViewController", imageName: "orderHistoryGray", selectedImageName: "orderHistoryBlue")
        let currentOrderViewController = instantiateViewController(identifier: "ClientCurrentOrderViewController", imageName: "currentOrderGray", selectedImageName: "currentOrderBlue")
        let profileViewController = instantiateViewController(identifier: "ClientProfileViewController", imageName: "profileGray", selectedImageName: "profileBlue")
        viewControllers = [orderHistoryViewController, currentOrderViewController, profileViewController]
        selectedIndex = 1
    }

    private func instantiateViewController(identifier: String, imageName: String, selectedImageName: String) -> UIViewController {
        guard let storyboard = storyboard else { return UIViewController() }
        let vc = storyboard.instantiateViewController(identifier: identifier)
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        return vc
    }
}
