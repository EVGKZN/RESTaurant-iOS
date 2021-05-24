//
//  OrderDetailPositionTableViewCell.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class OrderDetailPositionTableViewCell: UITableViewCell {

    @IBOutlet weak var positionStatusImageView: UIImageView!
    @IBOutlet weak var positionCostLabel: UILabel!
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var positionImageView: UIImageView!
    @IBOutlet weak var servedButton: UIButton!

    private var position: PositionResponse?
    public var servePosition: ((Int) -> Void)?


    @IBAction func servedButtonDidPress(_ sender: Any) {
        guard let position = position else { return }
        servePosition?(position.id)
    }

    func configure(position: PositionResponse) {
        self.position = position
        self.positionNameLabel.text = position.dish.name
        self.positionCostLabel.text = "\(position.dish.cost) руб."
        self.positionStatusImageView.image = getPositionStatusImage(status: position.status)
        if position.status == "COOKED" {
            servedButton.isHidden = false
        } else {
            servedButton.isHidden = true
        }
    }

    func getPositionStatusImage(status: String?) -> UIImage {
        let image: UIImage?
        switch status {
        case "CREATED":
            image = UIImage(named: "waiting")
        case "COOKING", "COOKED":
            image = UIImage(named: "cooking")
        case "DELIVERED":
            image = UIImage(named: "ready")
        default:
            image = UIImage()
        }
        guard let image = image else { return UIImage() }
        return image
    }
}
