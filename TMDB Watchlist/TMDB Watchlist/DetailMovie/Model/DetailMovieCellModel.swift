//
//  DetailMovieModelCell.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import Foundation
import UIKit

struct DetailMovieCellModel {
    var movie: Movie?
    var watchList: WatchList?
    var coreDataManager = CoreDataManager()
    var image = UIImage(named: "noImage")
}

extension DetailMovieCellModel {
    var name: String {
        return self.movie != nil ? self.movie?.title ?? NSLocalizedString("noTitle", comment: "") : self.watchList?.title ?? NSLocalizedString("noTitle", comment: "")
    }

    var date: String? {
        let date = self.movie != nil ? self.movie?.releaseDate : self.watchList?.realeaseDate
        return date
    }

    var synopsis: String {
        return self.movie != nil ? self.movie?.overview ?? NSLocalizedString("noTitle", comment: "") : self.watchList?.overview ?? NSLocalizedString("noTitle", comment: "")
    }

    var note: String {
        let note: Double = self.movie != nil ? self.movie?.voteAverage ?? 0 : self.watchList?.voteAverage ?? 0
        return "\(note)" + "/10"
    }

    var isWatchList: Bool {
        if watchList != nil {
            guard let title =  watchList!.title else { return false }
            return coreDataManager.searchRecord(title: title)
        } else {
            guard let movie = self.movie else {
                return false
            }
            return coreDataManager.searchRecord(title: movie.title)
        }
    }
}
