//
//  UserDefaultsHelper.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation

class UserDefaultsHelper {

    class func getCurrentTableID() -> String? {
        return UserDefaults.standard.string(forKey: GlobalConstants.userDefaultsCurrentTableIDKey)
    }

    class func setCurrentTableID(tableID: String?) {
        UserDefaults.standard.set(tableID, forKey: GlobalConstants.userDefaultsCurrentTableIDKey)
    }

    class func getCurrentAuthorizationInfo() -> AuthorizationResponse? {
        guard let savedAuthorizationResponse = UserDefaults.standard.object(forKey: GlobalConstants.userDefaultsCurrentAuthorizationInfoIDKey) as? Data else { return nil }
            let decoder = JSONDecoder()
        guard let authorizationResponse = try? decoder.decode(AuthorizationResponse.self, from: savedAuthorizationResponse) else { return nil }
        return authorizationResponse
    }

    class func setCurrentAuthorizationInfo(accountInfo: AuthorizationResponse?) {
        let encoder = JSONEncoder()
        if let encodedAccountInfo = try? encoder.encode(accountInfo) {
            UserDefaults.standard.set(encodedAccountInfo, forKey: GlobalConstants.userDefaultsCurrentAuthorizationInfoIDKey)
        }
    }

    class func getCurrentEmployeeInfo() -> EmployeeResponse? {
        guard let savedEmployeeResponse = UserDefaults.standard.object(forKey: GlobalConstants.userDefaultsCurrentEmployeeInfoIDKey) as? Data else { return nil }
            let decoder = JSONDecoder()
        guard let employeeResponse = try? decoder.decode(EmployeeResponse.self, from: savedEmployeeResponse) else { return nil }
        return employeeResponse
    }

    class func setCurrentEmployeeInfo(employeeInfo: EmployeeResponse?) {
        let encoder = JSONEncoder()
        if let encodedEmployeeInfo = try? encoder.encode(employeeInfo) {
            UserDefaults.standard.set(encodedEmployeeInfo, forKey: GlobalConstants.userDefaultsCurrentEmployeeInfoIDKey)
        }
    }
}
