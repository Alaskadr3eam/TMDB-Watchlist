//
//  WatchListViewController.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import UIKit

class WatchListViewController: BaseViewController {

    @IBOutlet weak var watchListCollectionView: UICollectionView!

    var watchListModel = WatchListModel()
    var coreDataManager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("watchList", comment: "")
        
        watchListCollectionView.backgroundColor = .systemGroupedBackground
        watchListCollectionView.delegate = self
        watchListCollectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        watchListModel.fetchAllWatchList()
        updateUI()
    }
    // MARK: - Helpers Function
    func updateUI() {
        watchListCollectionView.reloadData()
        if watchListModel.watchListCellModels.count == 0 {
            self.label.text = NSLocalizedString("noWatchList", comment: "")
            self.label.isHidden = false
            self.buttonRetry.isHidden = true
        } else {
            self.label.isHidden = true
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailMovie" {
            if let detailVC = segue.destination as? DetailMovieViewController {
                guard let indexPath = sender as? IndexPath else { return }
                let cell = watchListCollectionView.cellForItem(at: indexPath) as? WatchListCell
                
                let detailMovie = DetailMovieCellModel(movie: nil,
                                                       watchList: self.watchListModel.movieListCell(at: indexPath.row).watchList,
                                                       coreDataManager: CoreDataManager(),
                                                       image: cell?.posterImage.image)
                detailVC.detailMovieModel = detailMovie
            }
        }
    }
}
