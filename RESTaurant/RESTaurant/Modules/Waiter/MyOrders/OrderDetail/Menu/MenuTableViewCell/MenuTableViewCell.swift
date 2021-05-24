//
//  MenuTableViewCell.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var dishTypeLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    private var dish: DishResponse?
    public var addDishToOrder: ((Int) -> Void)?

    @IBAction func addDishToOrderDidPress(_ sender: Any) {
        guard let dish = dish else { return }
        addDishToOrder?(dish.id)
    }

    func configure(dish: DishResponse) {
        self.dish = dish
        nameLabel.text = dish.name
        costLabel.text = "\(dish.cost) руб."
        dishTypeLabel.text = "Тип блюда: \(dish.dishType)"
        dishDescriptionLabel.text = "Описание: \(dish.description)"
        compositionLabel.text = "\(dish.composition)"
        weightLabel.text = "Вес: \(dish.weight)"
    }
}
