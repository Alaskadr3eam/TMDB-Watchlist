//
//  MovieCellModel.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import Foundation

struct MovieCellModel {
    var movie: Movie
    var coreDataManager = CoreDataManager()
}

extension MovieCellModel {
    var name: String {
        return self.movie.title
    }

    var date: String? {
        let date = self.movie.releaseDate
        return date.dateFormatterFunc()
    }

    var image: String {
        return self.movie.posterPath ?? ""
    }

    var isWatchList: Bool {
        return coreDataManager.searchRecord(title: movie.title)
    }
}
