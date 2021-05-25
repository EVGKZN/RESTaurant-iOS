//
//  CookerFreePositionsViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 25.05.2021.
//

import UIKit

class CookerFreePositionsViewController: BaseViewController {

    @IBOutlet weak var freePositionsTableView: UITableView!
    @IBOutlet weak var emptyPositionsView: UIView!

    private let presenter: CookerFreePositionsPresenter = CookerFreePositionsPresenterDefault()
    private var freePositions: [PositionResponse] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupData()
        setupRefreshControl()
        presenter.attachView(view: self)
        presenter.loadFreePositions()
        showActivityIndicatorView()
    }

    private func setupTableView() {
        freePositionsTableView.delegate = self
        freePositionsTableView.dataSource = self
        freePositionsTableView.separatorStyle = .singleLine
        freePositionsTableView.registerCell(type: FreePositionsTableViewCell.self)
    }

    private func setupRefreshControl() {
        freePositionsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateInfo), for: .valueChanged)
    }

    @objc private func updateInfo() {
        presenter.loadFreePositions()
    }

    private func setupData() {
        if freePositions.isEmpty {
            emptyPositionsView.isHidden = false
            freePositionsTableView.isHidden = true
            freePositionsTableView.separatorStyle = .none
        } else {
            emptyPositionsView.isHidden = true
            freePositionsTableView.isHidden = false
            freePositionsTableView.separatorStyle = .singleLine
        }
    }

    private func addPositionToMyPositions(positionID: Int) {
        let alertController = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите взять данное блюдо на готовку?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            self?.showActivityIndicatorView()
            self?.presenter.addPositionToMyPositions(positionID: positionID)
        }
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func updateButtonDidPress(_ sender: Any) {
        showActivityIndicatorView()
        presenter.loadFreePositions()
    }
}

extension CookerFreePositionsViewController: CookerFreePositionsView {

    func showErrorAlert() {
        hideActivityIndicatorView()
        presentAlert(withTitle: "Ошибка", message: "Что-то пошло не так. Попробуйте снова позже")
    }

    func showFreePositions(positions: [PositionResponse]) {
        self.freePositions = positions
        freePositionsTableView.reloadData()
        setupData()
        hideActivityIndicatorView()
        refreshControl.endRefreshing()
    }
}

extension CookerFreePositionsViewController: UITableViewDelegate {

}

extension CookerFreePositionsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freePositions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: FreePositionsTableViewCell.self) as? FreePositionsTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(position: freePositions[indexPath.row])
        cell.addPositionToMyPositions = { [weak self] positionID in
            self?.addPositionToMyPositions(positionID: positionID)
        }
        return cell
    }
}

