//
//  MyPositionsTableViewCell.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import UIKit

class MyPositionsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dishTypeLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    private var position: PositionResponse?
    public var markPositionAsCooked: ((Int) -> Void)?

    @IBAction func markPositionAsCookedDidPress(_ sender: Any) {
        guard let position = position else { return }
        markPositionAsCooked?(position.id)
    }

    func configure(position: PositionResponse) {
        self.position = position
        nameLabel.text = position.dish.name
        dishTypeLabel.text = "Тип блюда: \(position.dish.dishType)"
        dishDescriptionLabel.text = "Описание: \(position.dish.description)"
        compositionLabel.text = "\(position.dish.composition)"
        weightLabel.text = "Вес: \(position.dish.weight)"
    }
}
