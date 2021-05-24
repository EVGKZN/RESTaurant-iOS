//
//  WaiterMyOrdersViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class WaiterMyOrdersViewController: BaseViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var myOrdersTableView: UITableView!
    
    private let presenter: WaiterMyOrdersPresenter = WaiterMyOrdersPresenterDefault()
    private var myOrders: [OrderResponse] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        setupTableView()
        setupData()
        setupRefreshControl()
        presenter.attachView(view: self)
        presenter.loadMyOrders()
        showActivityIndicatorView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    private func setupData() {
        if myOrders.isEmpty {
            emptyView.isHidden = false
            myOrdersTableView.isHidden = true
        } else {
            emptyView.isHidden = true
            myOrdersTableView.isHidden = false
        }
    }

    private func setupTableView() {
        myOrdersTableView.delegate = self
        myOrdersTableView.dataSource = self
        myOrdersTableView.separatorStyle = .none
        myOrdersTableView.registerCell(type: MyOrdersTableViewCell.self)
    }

    private func setupRefreshControl() {
        myOrdersTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }

    @objc private func updateData() {
        presenter.loadMyOrders()
    }

    @IBAction func updateDataDidPress(_ sender: Any) {
        showActivityIndicatorView()
        presenter.loadMyOrders()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOrderDetailSegue" {
            guard let order = sender as? OrderResponse, let destination = segue.destination as? OrderDetailViewController else { return }
            destination.configure(order: order)
        }
    }
}

extension WaiterMyOrdersViewController: WaiterMyOrdersView {

    func showMyOrders(orders: [OrderResponse]) {
        myOrders = orders
        refreshControl.endRefreshing()
        myOrdersTableView.reloadData()
        setupData()
        hideActivityIndicatorView()
    }

    func showErrorAlert() {
        hideActivityIndicatorView()
        presentAlert(withTitle: "Ошибка", message: "Что-то пошло не так. Попробуйте снова позже")
    }
}

extension WaiterMyOrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "toOrderDetailSegue", sender: myOrders[indexPath.row])
    }
}

extension WaiterMyOrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: MyOrdersTableViewCell.self) as? MyOrdersTableViewCell else { return UITableViewCell() }
        cell.configure(order: myOrders[indexPath.row])
        return cell
    }
}
