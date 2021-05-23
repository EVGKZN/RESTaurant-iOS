//
//  UITableViewCell+Extensions.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import UIKit

public extension UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }

}
