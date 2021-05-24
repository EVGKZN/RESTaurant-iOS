//
//  CookerProfileViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import UIKit

class CookerProfileViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var fatherNameLabel: UILabel!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }

    private func setupData() {
        let employeeInfo = UserDefaultsHelper.getCurrentEmployeeInfo()
        firstNameLabel.text = employeeInfo?.firstName
        lastNameLabel.text = employeeInfo?.lastName
        fatherNameLabel.text = employeeInfo?.fatherName
        if let restaurantName = employeeInfo?.restaurant.name {
            restaurantLabel.text = "Заведение: \(restaurantName)"
        }
        roleLabel.text = employeeInfo?.role == "WAITER" ? "Роль: Официант" : "Роль: Повар"
    }

    @IBAction func logoutButtonDidPress(_ sender: Any) {
        UserDefaultsHelper.setCurrentAuthorizationInfo(accountInfo: nil)
        UserDefaultsHelper.setCurrentEmployeeInfo(employeeInfo: nil)
        let storyboard = UIStoryboard(name: GlobalConstants.storyboardMainName, bundle: nil)
        let clientWorflowVc = storyboard.instantiateViewController(identifier: GlobalConstants.viewControllerMainMenuNavigationController)
        UIApplication.shared.windows.first?.rootViewController = clientWorflowVc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
