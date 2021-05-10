//
//  QRCodeScannerViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import UIKit

class QRCodeScannerViewController: UIViewController {

    private class Constants: GlobalConstants { }

    @IBOutlet weak var qrScannerView: QRScannerView! {
        didSet {
            qrScannerView.delegate = self
        }
    }

    var qrData: QRData? = nil {
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

        setupNavigationController()
    }

    private func setupNavigationController() {
        self.navigationController?.navigationBar.tintColor = Constants.brandWhiteColor
    }
}

extension QRCodeScannerViewController: QRScannerViewDelegate {
    func qrScanningDidStop() {

    }

    func qrScanningDidFail() {
        presentAlert(withTitle: "Ошибка", message: "Сканирование не удалось. Попробуйте еще раз")
    }

    func qrScanningSucceededWithCode(_ str: String?) {
        self.qrData = QRData(codeString: str)
        guard let code = str else { return }
        let alertController = UIAlertController(title: "Результат сканирования", message: code, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            self?.qrScannerView.startScanning()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
