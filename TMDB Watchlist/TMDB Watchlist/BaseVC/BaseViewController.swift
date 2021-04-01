//
//  BaseViewController.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import UIKit

class BaseViewController: UIViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var buttonRetry: UIButton!
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)

        label = UILabel()
        label.center = self.view.center
        label.textColor = .black
        label.textAlignment = .center
        label.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 80)
        label.numberOfLines = 0
        label.text = NSLocalizedString("messageNoList", comment: "")
        self.view.addSubview(label)

        buttonRetry = UIButton()
        buttonRetry.setBackgroundImage(UIImage(systemName: "repeat.circle"), for: .normal)
        buttonRetry.addTarget(self, action: #selector(buttonRetryTouched), for: .touchUpInside)
        buttonRetry.frame = CGRect(x: UIScreen.main.bounds.width/2 - 20,
                                   y: self.label.frame.width + 10,
                                   width: 40,
                                   height: 40)
        buttonRetry.tintColor = .systemRed
        self.view.addSubview(buttonRetry)
        self.label.isHidden = true
        self.buttonRetry.isHidden = true
        self.activityIndicatorView.isHidden = true
    }
    // MARK: - Action
    @objc func buttonRetryTouched() {}
}
