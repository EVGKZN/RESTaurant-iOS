//
//  FreeOrdersTableViewCell.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class FreeOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var seatNumberLabel: UILabel!
    @IBOutlet weak var reserveTimeLabel: UILabel!
    @IBOutlet weak var takeOrderButton: UIButton!

    private var order: OrderResponse?
    public var takeOrder: ((String) -> Void)?
    
    @IBAction func takeOrderDidPress(_ sender: Any) {
        guard let order = order else { return }
        takeOrder?(order.id)
    }

    func configure(order: OrderResponse) {
        self.order = order
        tableNumberLabel.text = "Стол №\(order.table.number)"
        seatNumberLabel.text = "Количество мест: \(order.table.seatCount)"
        reserveTimeLabel.text = "Время бронирования: \(DateFormatterHelper.getHoursAndMinutedFromDate(date: order.createTime))"
    }
}
