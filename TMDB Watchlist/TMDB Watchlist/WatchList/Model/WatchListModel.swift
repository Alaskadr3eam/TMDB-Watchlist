//
//  WatchList.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import Foundation

class WatchListModel {

    var coreDataManager = CoreDataManager()
    var watchListCellModels: [WatchListCellModel]
    var watchList: [WatchList]

    deinit {}

    init() {
        self.watchList = coreDataManager.fetchAllWatchList()
        self.watchListCellModels = watchList.map { WatchListCellModel(watchList: $0) }
    }

    func fetchAllWatchList() {
        self.watchList = coreDataManager.fetchAllWatchList()
        self.watchListCellModels = watchList.map { WatchListCellModel(watchList: $0) }
    }

    func movieListCell(at index: Int) -> WatchListCellModel {
        self.watchListCellModels[index]
    }
}
