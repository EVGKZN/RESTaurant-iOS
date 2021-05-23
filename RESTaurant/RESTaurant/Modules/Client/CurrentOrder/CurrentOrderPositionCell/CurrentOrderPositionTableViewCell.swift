//
//  CurrentOrderPositionTableViewCell.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import UIKit

class CurrentOrderPositionTableViewCell: UITableViewCell {

    @IBOutlet weak var positionStatusImageView: UIImageView!
    @IBOutlet weak var positionCostLabel: UILabel!
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var positionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(position: PositionResponse) {
        self.positionNameLabel.text = position.dish?.name
        self.positionCostLabel.text = "\(position.dish?.cost)"
        self.positionStatusImageView.image = getPositionStatusImage(status: position.status)
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
