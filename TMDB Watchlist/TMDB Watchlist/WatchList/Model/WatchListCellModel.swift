//
//  WatchListCellModel.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import Foundation
import UIKit

struct WatchListCellModel {
    var watchList: WatchList
}

extension WatchListCellModel {
    var name: String {
        return self.watchList.title ?? ""
    }

    var date: String? {
        return self.watchList.realeaseDate ?? ""
    }

    var imageData: UIImage {
        guard let imageData = self.watchList.image else {
            return UIImage(named: "noImage")!
        }
        guard let image = UIImage(data: imageData) else {
            return UIImage(named: "noImage")!
        }
        return image
    }
}
