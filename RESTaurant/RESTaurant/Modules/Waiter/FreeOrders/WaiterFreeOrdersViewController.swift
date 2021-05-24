//
//  WaiterFreeOrdersViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class WaiterFreeOrdersViewController: BaseViewController {

    @IBOutlet weak var freeOrdersTableView: UITableView!
    @IBOutlet weak var emptyOrdersView: UIView!
    
    private let presenter: WaiterFreeOrdersPresenter = WaiterFreeOrdersPresenterDefault()
    private var freeOrders: [OrderResponse] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupData()
        setupRefreshControl()
        presenter.attachView(view: self)
        presenter.loadFreeOrders()
        showActivityIndicatorView()
    }

    private func setupTableView() {
        freeOrdersTableView.delegate = self
        freeOrdersTableView.dataSource = self
        freeOrdersTableView.separatorStyle = .none
        freeOrdersTableView.registerCell(type: FreeOrdersTableViewCell.self)
    }

    private func setupData() {
        if freeOrders.isEmpty {
            freeOrdersTableView.isHidden = true
            emptyOrdersView.isHidden = false
        } else {
            freeOrdersTableView.isHidden = false
            emptyOrdersView.isHidden = true
        }
    }

    private func setupRefreshControl() {
        freeOrdersTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }

    private func takeOrder(orderID: String) {
        showActivityIndicatorView()
        presenter.takeOrder(orderID: orderID)
    }

    @objc private func updateData() {
        presenter.loadFreeOrders()
    }

    @IBAction func updateDataDidPress(_ sender: Any) {
        showActivityIndicatorView()
        presenter.loadFreeOrders()
    }
}

extension WaiterFreeOrdersViewController: UITableViewDelegate { }

extension WaiterFreeOrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeOrders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: FreeOrdersTableViewCell.self) as? FreeOrdersTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(order: freeOrders[indexPath.row])
        cell.takeOrder = { orderID in
            self.takeOrder(orderID: orderID)
        }
        return cell
    }
}

extension WaiterFreeOrdersViewController: WaiterFreeOrdersView {
    func showErrorAlert() {
        hideActivityIndicatorView()
        presentAlert(withTitle: "Ошибка", message: "Что-то пошло не так. Попробуйте снова позже")
    }

    func presentFreeOrders(orders: [OrderResponse]) {
        self.freeOrders = orders
        freeOrdersTableView.reloadData()
        setupData()
        refreshControl.endRefreshing()
        hideActivityIndicatorView()
    }
}
