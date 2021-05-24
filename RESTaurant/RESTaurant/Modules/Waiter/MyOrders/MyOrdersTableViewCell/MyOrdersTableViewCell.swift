//
//  MyOrdersTableViewCell.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var seatNumberLabel: UILabel!
    @IBOutlet weak var reserveTimeLabel: UILabel!

    private var order: OrderResponse?

    func configure(order: OrderResponse) {
        self.order = order
        tableNumberLabel.text = "Стол №\(order.table.number)"
        seatNumberLabel.text = "Количество мест: \(order.table.seatCount)"
        reserveTimeLabel.text = "Время бронирования: \(DateFormatterHelper.getHoursAndMinutedFromDate(date: order.createTime))"
    }
}
