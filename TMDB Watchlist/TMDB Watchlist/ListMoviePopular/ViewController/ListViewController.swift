//
//  ListViewController.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import UIKit

class ListViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var listMovieModel = ListMovie(movieServiceSession: MovieService(movieSession: URLSession(configuration: .default)))
    // scrollview
    var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.title = NSLocalizedString("popularMovies", comment: "")

        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        listMovieModel.delegate = self

        firstRequestPopularMovie()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.reloadData()
    }
    // MARK: - Request
    private func firstRequestPopularMovie() {
        showProgress()
        listMovieModel.getPopularMovieList(page: "1") { [weak self] (bool) in
            guard let self = self else { return }
            guard bool == true else {
                self.hideProgressWithButton()
                return
            }
        }
    }

    func requestPopularMovie(page: String) {
        listMovieModel.getPopularMovieList(page: page) { [weak self] (bool) in
            guard let self = self else { return }
            guard bool == true else {
                self.hideProgressWithAlert()
                return
            }
        }
    }
    // MARK: - Helpers
    func showProgress() {
        self.collectionView.isHidden = true
        self.buttonRetry.isHidden = true
        self.label.isHidden = true
        self.activityIndicatorView.startAnimating()
    }

    func hideProgressWithButton() {
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.isHidden = true
        self.label.isHidden = false
        self.buttonRetry.isHidden = false
    }

    func hideProgressWithAlert() {
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.isHidden = true
        self.buttonRetry.isHidden = true
        self.label.isHidden = true
        self.presentAlert(title: NSLocalizedString("warning", comment: ""),
                          message: NSLocalizedString("warning", comment: ""))
    }

    func hideProgress() {
        self.activityIndicatorView.stopAnimating()
        self.collectionView.isHidden = false
        self.buttonRetry.isHidden = true
        self.label.isHidden = true
        self.activityIndicatorView.isHidden = true
    }
    // MARK: - Action
    override func buttonRetryTouched() {
        firstRequestPopularMovie()
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailMovie" {
            if let detailVC = segue.destination as? DetailMovieViewController {
                guard let indexPath = sender as? IndexPath else { return }
                let cell = collectionView.cellForItem(at: indexPath) as? MovieListCell
                var detailMovie = DetailMovieCellModel(movie: self.listMovieModel.movieListCell(at: indexPath.row).movie)
                detailMovie.image = cell?.posterImage.image
                detailVC.detailMovieModel = detailMovie
            }
        }
    }
}
