//
//  DetailMovieViewController.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var detailCollectionView: UICollectionView!

    var coreDataManager = CoreDataManager()
    var detailMovieModel: DetailMovieCellModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.title = detailMovieModel?.name
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    // MARK: - Action
    @IBAction func favoriteButtonIsClicked() {
        guard let detailMovieModel = detailMovieModel else { return }
        if coreDataManager.searchRecord(title: detailMovieModel.movie?.title ?? "") {
            guard let title = detailMovieModel.movie?.title else { return }
            guard let watchListDelete = coreDataManager.fetchWatchList(title: title) else { return }
            coreDataManager.deleteMovieInWatchList(movieCoreData: watchListDelete)
        } else if detailMovieModel.watchList != nil {
            coreDataManager.deleteMovieInWatchList(movieCoreData: detailMovieModel.watchList!)
        } else {
            guard let image = detailMovieModel.image else { return }
            guard let movie = detailMovieModel.movie else { return }
            coreDataManager.addMovieInWatchList(movie: movie, image: image)
        }
        let indexPath = IndexPath(item: 1, section: 1)
        let indexSet = IndexSet(indexPath)
        self.detailCollectionView.reloadSections(indexSet)
    }
}
