//
//  NetworkError.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import Foundation
import UIKit

// Give information on the error encountered in a request
enum NetworkError: String {
    /// The request URL could not be generate
    case invalidRequestURL = "invalidDataProvider"//"Invalid data provider"
    
    /// The API returned an error
    case errorFromAPI = "theRequestReturneAnError"//"The request returned an error"
    
    /// The request returned an bad response
    case badResponse = "theRequestReturnedABadResponse"//"The request returned a bad response"
    
    /// Data are empty
    case emptyData = "noDataFound"//"No data found"
    
    /// Json decoding failed
    case jsonDecodeFailed = "unexpectedData"//"Unexpected data"
    
    static func getAlert(_ error: NetworkError) -> UIAlertController {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString(error.rawValue, comment: ""), preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: nil)
        alert.addAction(confirmAction)
        return alert
    }
}
