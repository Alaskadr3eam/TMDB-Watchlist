//
//  Extension+ListViewController.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import UIKit

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return listMovieModel.moviesListCellModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieListCell",
                                                            for: indexPath) as? MovieListCell else {
            return UICollectionViewCell()
        }

        cell.model = self.listMovieModel.movieListCell(at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let middle = listMovieModel.moviesListCellModels.count / 2
        if indexPath.section == collectionView.numberOfSections - 1
            && indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - middle {
            scroll(collectionView)
        }
    }
    //ScrollView
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }

    func scroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            listMovieModel.prepareNumberPageForRequest()
            requestPopularMovie(page: Constant.page)
        }
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        return CGSize(width: UIScreen.main.bounds.width - spacing * 2, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailMovie", sender: indexPath)
    }
}

extension ListViewController: ListMovieDelegate {
    func failReceiveWeatherData(error: NetworkError) {
        self.present(NetworkError.getAlert(error), animated: true)
    }
    
    func weReceiveWeatherData() {
        self.hideProgress()
        self.collectionView.reloadData()
    }
}
