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
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(view: self)
        setupOrderContainerView()
        setupOrderPositionsTableView()
        setupRefreshControl()
        noPositionsView.isHidden = false
        orderContainterView.isHidden = true
        presenter.loadOrderInfo()
        showActivityIndicatorView()
    }

    private func setupData() {
        if let orderInfo = orderInfo {
            if orderInfo.positions.isEmpty {
                noPositionsView.isHidden = false
                orderContainterView.isHidden = true
            } else {
                var totalAmount: Int = 0
                for position in orderInfo.positions {
                    totalAmount += position.dish.cost
                }
                totalAmountLabel.text = "\(totalAmount) руб."
                noPositionsView.isHidden = true
                orderContainterView.isHidden = false

                if let employee = orderInfo.employee {
                    self.waiterNameLabel.text = "\(employee.firstName) \(employee.lastName)"
                }
                tableNumberLabel.text = "\(orderInfo.table.number)"

                let fromDateFormatter = ISO8601DateFormatter()
                if let fromIndex = orderInfo.createTime.firstIndex(of: "."), let toIndex = orderInfo.createTime.firstIndex(of: "+") {
                    var normalizedStringDate = orderInfo.createTime
                    normalizedStringDate.removeSubrange(fromIndex..<toIndex)
                    if let date = fromDateFormatter.date(from: normalizedStringDate) {
                        let toDateFormatter = DateFormatter()
                        toDateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                        toDateFormatter.dateFormat = "HH:mm"
                        let dateString = toDateFormatter.string(from: date)
                        reservationTimeLabel.text = dateString
                    }
                }
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
        if #available(iOS 10.0, *) {
            orderPositionsTableView.refreshControl = refreshControl
        } else {
            orderPositionsTableView.addSubview(refreshControl)
        }
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshOrderInfo), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Обновляем состояние заказа...", attributes: nil)
    }

    @objc private func refreshOrderInfo() {
        presenter.loadOrderInfo()
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
        cell.selectionStyle = .none
        guard let position = orderInfo?.positions[indexPath.row] else { return cell }
        cell.configure(position: position)
        return cell
    }
}

extension ClientCurrentOrderViewController: ClientCurrentOrderView {
    func showOrderInfo(info: OrderResponse) {
        refreshControl.endRefreshing()
        self.orderInfo = info
        setupData()
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
