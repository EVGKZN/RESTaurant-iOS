//
//  BaseViewController.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 10.05.2021.
//

import UIKit

class BaseViewController: UIViewController {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var grayView: UIView = UIView()

    func showActivityIndicatorView() {
        grayView = UIView()
        grayView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        grayView.backgroundColor = .darkGray
        grayView.alpha = 0.5
        self.view.addSubview(grayView)

        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

    }

    func hideActivityIndicatorView() {
        self.activityIndicator.stopAnimating()
        self.grayView.removeFromSuperview()
    }
}
