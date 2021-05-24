//
//  FreePositionsTableViewCell.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import UIKit

class FreePositionsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dishTypeLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    private var position: PositionResponse?
    public var addPositionToMyPositions: ((Int) -> Void)?

    @IBAction func addDishToMyPositionsDidPress(_ sender: Any) {
        guard let position = position else { return }
        addPositionToMyPositions?(position.id)
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
