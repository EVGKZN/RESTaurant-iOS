//
//  WaiterProfileViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class WaiterProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutButtonDidPress(_ sender: Any) {
        UserDefaultsHelper.setCurrentAuthorizationInfo(accountInfo: nil)
        UserDefaultsHelper.setCurrentEmployeeInfo(employeeInfo: nil)
        let storyboard = UIStoryboard(name: GlobalConstants.storyboardMainName, bundle: nil)
        let clientWorflowVc = storyboard.instantiateViewController(identifier: GlobalConstants.viewControllerMainMenuNavigationController)
        UIApplication.shared.windows.first?.rootViewController = clientWorflowVc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
