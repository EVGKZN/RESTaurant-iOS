//
//  QRCodeScannerViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import UIKit

class QRCodeScannerViewController: BaseViewController {

    private let presenter: QRCodeScannerPresenter = QRCodeScannerPresenterDefault()

    private class Constants: GlobalConstants { }

    @IBOutlet private var qrScannerView: QRScannerView! {
        didSet {
            qrScannerView.delegate = self
        }
    }

    private var qrData: QRData? = nil {
        didSet {
            if qrData != nil {

            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !qrScannerView.isRunning {
            qrScannerView.startScanning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !qrScannerView.isRunning {
            qrScannerView.stopScanning()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(view: self)
        setupNavigationController()
    }

    private func setupNavigationController() {
        self.navigationController?.navigationBar.tintColor = Constants.brandWhiteColor
    }
}

extension QRCodeScannerViewController: QRScannerViewDelegate {
    func qrScanningDidStop() { }

    func qrScanningDidFail() {
        hideActivityIndicatorView()
        presentAlert(withTitle: Constants.errorTitle, message: "Сканирование не удалось. Попробуйте еще раз")
    }

    func qrScanningSucceededWithCode(_ str: String?) {
        guard let result = str else {
            qrScanningDidFail()
            return
        }
        showActivityIndicatorView()
        presenter.checkQRCodeScanningResult(result: result)
    }
}

extension QRCodeScannerViewController: QRCodeScannerView {
    func performSuccessfulTableReserving() {
        let storyboard = UIStoryboard(name: Constants.storyboardClientWorkflowName, bundle: nil)
        let clientWorflowVc = storyboard.instantiateViewController(identifier: Constants.viewControllerClientTabBarName)
        UIApplication.shared.windows.first?.rootViewController = clientWorflowVc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    func showErrorAlert() {
        let alertController = UIAlertController(title: Constants.errorTitle, message: "Что-то пошло не так, попробуйте еще раз позже", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            self?.hideActivityIndicatorView()
            self?.qrScannerView.startScanning()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
