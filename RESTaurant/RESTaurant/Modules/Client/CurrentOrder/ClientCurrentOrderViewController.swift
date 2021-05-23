//
//  ClientCurrentOrderViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 23.05.2021.
//

import UIKit

class ClientCurrentOrderViewController: BaseViewController {

    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var reservationTimeLabel: UILabel!
    @IBOutlet weak var waiterNameLabel: UILabel!
    @IBOutlet weak var orderContainterView: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var orderPositionsTableView: UITableView!
    @IBOutlet weak var noPositionsView: UIView!
    
    private let presenter: ClientCurrentOrderPresenter = ClientCurrentOrderPresenterDefault()
    private var orderInfo: OrderResponse? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(view: self)
        setupOrderContainerView()
        setupOrderPositionsTableView()
        checkOrderPositions()
        presenter.loadOrderInfo()
        showActivityIndicatorView()
    }

    private func checkOrderPositions() {
        if let orderInfo = orderInfo {
            if orderInfo.positions.isEmpty {
                noPositionsView.isHidden = false
                orderContainterView.isHidden = true
            } else {
                noPositionsView.isHidden = true
                orderContainterView.isHidden = false
            }
        } else {
            noPositionsView.isHidden = false
            orderContainterView.isHidden = true
        }
    }

    private func setupOrderContainerView() {
        orderContainterView.layer.cornerRadius = 20
        orderContainterView.layer.maskedCorners = .layerMaxXMinYCorner
        noPositionsView.layer.cornerRadius = 20
        noPositionsView.layer.maskedCorners = .layerMaxXMinYCorner
    }

    private func setupOrderPositionsTableView() {
        orderPositionsTableView.delegate = self
        orderPositionsTableView.dataSource = self
        orderPositionsTableView.registerCell(type: CurrentOrderPositionTableViewCell.self, identifier: nil)
        orderPositionsTableView.separatorStyle = .none
    }
}

extension ClientCurrentOrderViewController : UITableViewDelegate { }

extension ClientCurrentOrderViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orderInfo = orderInfo else { return 0 }
        return orderInfo.positions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CurrentOrderPositionTableViewCell.self) as? CurrentOrderPositionTableViewCell else { return UITableViewCell() }
        guard let position = orderInfo?.positions[indexPath.row] else { return cell }
        cell.configure(position: position)
        return cell
    }
}

extension ClientCurrentOrderViewController: ClientCurrentOrderView {
    func showOrderInfo(info: OrderResponse) {
        self.orderInfo = info
        if let employee = orderInfo?.employee {
            self.waiterNameLabel.text = "\(employee.firstName) \(employee.lastName)"
        }
        checkOrderPositions()
        orderPositionsTableView.reloadData()
        hideActivityIndicatorView()
    }

    func presentFailure(message: String) {
        presentAlert(withTitle: "Внутренняя ошибка приложения", message: "Сообщение: \(message)")
    }

    func presentNetworkFailure(errorCode: Int) {
        presentAlert(withTitle: "Ошибка сервера", message: "Код ошибки: \(errorCode)")
    }
}
