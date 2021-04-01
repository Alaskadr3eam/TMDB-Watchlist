//
//  Extension.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import Foundation
import UIKit

extension String {
    func dateFormatterFunc() -> String {
        var formattedDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let newDate = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy"
            formattedDate =  dateFormatter.string(from: newDate)
        }
        return formattedDate
    }
}

extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
