//
//  CookerMyPositionsViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import UIKit

class CookerMyPositionsViewController: BaseViewController {

    @IBOutlet weak var myPositionsTableView: UITableView!
    @IBOutlet weak var emptyPositionsView: UIView!
    
    private var myPositions: [PositionResponse] = []
    private let presenter: CookerMyPositionsPresenter = CookerMyPositionsPresenterDefault()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupData()
        setupRefreshControl()
        presenter.attachView(view: self)
        presenter.loadMyPositions()
        showActivityIndicatorView()
    }

    private func setupTableView() {
        myPositionsTableView.delegate = self
        myPositionsTableView.dataSource = self
        myPositionsTableView.separatorStyle = .singleLine
        myPositionsTableView.registerCell(type: MyPositionsTableViewCell.self)
    }

    private func setupRefreshControl() {
        myPositionsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateInfo), for: .valueChanged)
    }

    private func setupData() {
        if myPositions.isEmpty {
            emptyPositionsView.isHidden = false
            myPositionsTableView.isHidden = true
            myPositionsTableView.separatorStyle = .none
        } else {
            emptyPositionsView.isHidden = true
            myPositionsTableView.isHidden = false
            myPositionsTableView.separatorStyle = .singleLine
        }
    }

    @objc private func updateInfo() {
        presenter.loadMyPositions()
    }

    @IBAction func updateButtonDidPress(_ sender: Any) {
        showActivityIndicatorView()
        presenter.loadMyPositions()
    }

    private func markPositionsAsCooked(positinID: Int) {
        let alertController = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите пометить данное блюдо готовым?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            self?.showActivityIndicatorView()
            self?.presenter.markPositionAsCooked(positionID: positinID)
        }
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension CookerMyPositionsViewController: CookerMyPositionsView {
    
    func showErrorAlert() {
        hideActivityIndicatorView()
        presentAlert(withTitle: "Ошибка", message: "Что-то пошло не так. Попробуйте снова позже")
    }

    func showMyPositions(positions: [PositionResponse]) {
        self.myPositions = positions
        myPositionsTableView.reloadData()
        setupData()
        hideActivityIndicatorView()
        refreshControl.endRefreshing()
    }
}

extension CookerMyPositionsViewController: UITableViewDelegate {

}

extension CookerMyPositionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPositions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: MyPositionsTableViewCell.self) as? MyPositionsTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(position: myPositions[indexPath.row])
        cell.markPositionAsCooked = { [weak self] positionID in
            self?.markPositionsAsCooked(positinID: positionID)
        }
        return cell
    }
}
