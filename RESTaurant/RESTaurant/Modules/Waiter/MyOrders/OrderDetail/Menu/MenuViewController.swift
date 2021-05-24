//
//  MenuViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class MenuViewController: BaseViewController {

    @IBOutlet weak var menuTableView: UITableView!
    
    private let presenter: MenuPresenter = MenuPresenterDefault()
    private var dishes: [DishResponse] = []
    private var temporaryDishes: [DishResponse] = []
    private var order: OrderResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        presenter.attachView(view: self)
        guard let employeeInfo = UserDefaultsHelper.getCurrentEmployeeInfo() else {
            return
        }
        presenter.loadMenu(restaurantID: employeeInfo.restaurant.id)
        showActivityIndicatorView()
    }

    public func configure(order: OrderResponse) {
        self.order = order
    }

    private func setupTableView() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.separatorStyle = .none
        menuTableView.registerCell(type: MenuTableViewCell.self)
    }

    private func addDishToOrder(dishID: Int) {
        let alertController = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите добавить данное блюдо в заказ?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            self?.showActivityIndicatorView()
            guard let order = self?.order else { return }
            self?.presenter.addDishToOrder(dishID: dishID, orderID: order.id)
        }
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }

}

extension MenuViewController: MenuView {

    func reloadData() {
        self.dishes = self.temporaryDishes
        self.temporaryDishes = []
        if dishes.isEmpty {
            menuTableView.separatorStyle = .none
        } else {
            menuTableView.separatorStyle = .singleLine
        }
        menuTableView.reloadData()
        hideActivityIndicatorView()
    }

    func showErrorAlert() {
        hideActivityIndicatorView()
        presentAlert(withTitle: "Ошибка", message: "Что-то пошло не так. Попробуйте снова позже")
    }

    func addDishesToMenu(dishes: [DishResponse]) {
        self.temporaryDishes.append(contentsOf: dishes)
    }

    func performSuccessfulAddingDishToOrder() {
        hideActivityIndicatorView()
    }
}

extension MenuViewController: UITableViewDelegate {

}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: MenuTableViewCell.self) as? MenuTableViewCell else { return UITableViewCell() }
        cell.configure(dish: dishes[indexPath.row])
        cell.selectionStyle = .none
        cell.addDishToOrder = { [weak self] dishID in
            self?.addDishToOrder(dishID: dishID)
        }
        return cell
    }


}
