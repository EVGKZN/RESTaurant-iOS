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
    @IBOutlet weak var orderContainerView: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var orderPositionsTableView: UITableView!
    @IBOutlet weak var emptyPositionsView: UIView!
    
    private let presenter: ClientCurrentOrderPresenter = ClientCurrentOrderPresenterDefault()
    private var orderInfo: OrderResponse? = nil
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(view: self)
        setupOrderContainerView()
        setupOrderPositionsTableView()
        setupRefreshControl()
        emptyPositionsView.isHidden = false
        orderContainerView.isHidden = true
        presenter.loadOrderInfo()
        showActivityIndicatorView()
    }

    private func setupData() {
        if let orderInfo = orderInfo {
            if let employee = orderInfo.employee {
                self.waiterNameLabel.text = "\(employee.firstName) \(employee.lastName)"
            }
            tableNumberLabel.text = "\(orderInfo.table.number)"
            reservationTimeLabel.text = DateFormatterHelper.getHoursAndMinutedFromDate(date: orderInfo.createTime)
            if orderInfo.positions.isEmpty {
                emptyPositionsView.isHidden = false
                orderContainerView.isHidden = true
            } else {
                var totalAmount: Int = 0
                for position in orderInfo.positions {
                    totalAmount += position.dish.cost
                }
                totalAmountLabel.text = "\(totalAmount) руб."
                emptyPositionsView.isHidden = true
                orderContainerView.isHidden = false
            }
        } else {
            emptyPositionsView.isHidden = false
            orderContainerView.isHidden = true
        }
    }

    private func setupOrderContainerView() {
        orderContainerView.layer.cornerRadius = 20
        orderContainerView.layer.maskedCorners = .layerMaxXMinYCorner
        emptyPositionsView.layer.cornerRadius = 20
        emptyPositionsView.layer.maskedCorners = .layerMaxXMinYCorner
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

    func showClosedOrderAlert() {
        let alertController = UIAlertController(title: "Заказ закрыт", message: "Благодарим вас за посещение ресторана, будем рады видеть вас снова!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "До свидания", style: .default) { _ in
            let storyboard = UIStoryboard(name: GlobalConstants.storyboardMainName, bundle: nil)
            let clientWorflowVc = storyboard.instantiateViewController(identifier: GlobalConstants.viewControllerMainMenuNavigationController)
            UIApplication.shared.windows.first?.rootViewController = clientWorflowVc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func showErrorAlert() {
        hideActivityIndicatorView()
        presentAlert(withTitle: "Ошибка", message: "Что-то пошло не так. Попробуйте снова позже")
    }
}
