//
//  OrderDetailViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import UIKit

class OrderDetailViewController: BaseViewController {

    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var reservationTimeLabel: UILabel!
    @IBOutlet weak var seatCounterLabel: UILabel!
    @IBOutlet weak var orderContainerView: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var orderPositionsTableView: UITableView!
    @IBOutlet weak var emptyPositionsView: UIView!
    @IBOutlet weak var closeOrderButton: UIButton!
    
    private var order: OrderResponse?
    private let presenter: OrderDetailPresenter = OrderDetailPresenterDefault()
    private let refreshControl = UIRefreshControl()
    private var hasAlreadyBeenPresented: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(view: self)
        setupNavigationController()
        setupTableView()
        setupData()
        setupCloseOrderButton()
        setupOrderContainerView()
        setupRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if hasAlreadyBeenPresented {
            showActivityIndicatorView()
            updateData()
        } else {
            hasAlreadyBeenPresented.toggle()
        }
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = GlobalConstants.brandWhiteColor
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuButtonDidPress))
        navigationItem.rightBarButtonItem = menuButton
    }


    private func setupCloseOrderButton() {
        closeOrderButton.setTitleColor(UIColor.lightGray, for: .disabled)
        closeOrderButton.setTitleColor(GlobalConstants.brandBlueColor, for: .normal)
    }

    private func setupData() {
        guard let order = order else {
            emptyPositionsView.isHidden = false
            orderContainerView.isHidden = true
            closeOrderButton.isEnabled = false
            return
        }
        if let _ = order.positions.first(where: { $0.status != "DELIVERED" }) {
            closeOrderButton.isEnabled = false
        } else {
            closeOrderButton.isEnabled = true
        }
        tableNumberLabel.text = "Стол №\(order.table.number)"
        reservationTimeLabel.text = DateFormatterHelper.getHoursAndMinutedFromDate(date: order.createTime)
        seatCounterLabel.text = "\(order.table.seatCount)"
        if order.positions.isEmpty {
            emptyPositionsView.isHidden = false
            orderContainerView.isHidden = true
        } else {
            var totalAmount: Int = 0
            for position in order.positions {
                totalAmount += position.dish.cost
            }
            totalAmountLabel.text = "\(totalAmount) руб."
            emptyPositionsView.isHidden = true
            orderContainerView.isHidden = false
        }
    }

    private func setupRefreshControl() {
        orderPositionsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }

    private func setupTableView() {
        orderPositionsTableView.delegate = self
        orderPositionsTableView.dataSource = self
        orderPositionsTableView.separatorStyle = .none
        orderPositionsTableView.registerCell(type: OrderDetailPositionTableViewCell.self)
    }

    private func setupOrderContainerView() {
        orderContainerView.layer.cornerRadius = 20
        orderContainerView.layer.maskedCorners = .layerMaxXMinYCorner
        emptyPositionsView.layer.cornerRadius = 20
        emptyPositionsView.layer.maskedCorners = .layerMaxXMinYCorner
    }

    public func configure(order: OrderResponse) {
        self.order = order
    }

    @objc private func updateData() {
        guard let order = order else { return }
        presenter.loadOrder(orderID: order.id)
    }

    @IBAction func updateButtonDidPress(_ sender: Any) {
        showActivityIndicatorView()
        updateData()
    }

    private func servePosition(positionID: Int) {
        let alertController = UIAlertController(title: "Подтверждение", message: "Вы уверены, что блюдо подано?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            self?.showActivityIndicatorView()
            self?.presenter.servePosition(positionID: positionID, positionStatus: "DELIVERED")
        }
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc private func menuButtonDidPress() {
        performSegue(withIdentifier: "toMenuViewController", sender: order)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMenuViewController" {
            guard let order = sender as? OrderResponse, let destination = segue.destination as? MenuViewController else { return }
            destination.configure(order: order)
        }
    }
    @IBAction func closeOrderDidPress(_ sender: Any) {
        let alertController = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите пометить данное блюдо готовым?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            guard let order = self?.order else { return }
            self?.showActivityIndicatorView()
            self?.presenter.closeOrder(orderID: order.id)
        }
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension OrderDetailViewController: UITableViewDelegate {

}

extension OrderDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let order = order else { return 0 }
        return order.positions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: OrderDetailPositionTableViewCell.self) as? OrderDetailPositionTableViewCell else { return UITableViewCell() }
        guard let order = order else { return cell }
        cell.selectionStyle = .none
        cell.configure(position: order.positions[indexPath.row])
        cell.servePosition = { [weak self] positionID in
            self?.servePosition(positionID: positionID)
        }
        return cell
    }
}

extension OrderDetailViewController: OrderDetailView {
    func showErrorAlert() {
        hideActivityIndicatorView()
        presentAlert(withTitle: "Ошибка", message: "Что-то пошло не так. Попробуйте снова позже")
    }

    func showOrder(order: OrderResponse) {
        self.order = order
        setupData()
        orderPositionsTableView.reloadData()
        refreshControl.endRefreshing()
        hideActivityIndicatorView()
    }

    func positionSuccessfulServed() {
        updateData()
    }

    func performSuccessfulOrderdClosing() {
        hideActivityIndicatorView()
        navigationController?.popViewController(animated: true)
    }
}
