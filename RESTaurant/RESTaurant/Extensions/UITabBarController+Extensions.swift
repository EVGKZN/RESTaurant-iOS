//
//  UITabBarController+Extensions.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

extension UITabBarController {
    public func instantiateViewController(identifier: String, imageName: String, selectedImageName: String) -> UIViewController {
        guard let storyboard = storyboard else { return UIViewController() }
        let vc = storyboard.instantiateViewController(identifier: identifier)
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        return vc
    }
}
