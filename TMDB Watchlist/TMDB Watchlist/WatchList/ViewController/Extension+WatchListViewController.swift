//
//  Extension+WatchListViewController.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import UIKit

extension WatchListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchListModel.watchListCellModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchListCell",
                                                            for: indexPath) as? WatchListCell else {
            return UICollectionViewCell()
        }
        cell.model = watchListModel.movieListCell(at: indexPath.row)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailMovie", sender: indexPath)
    }
}

extension WatchListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let widthCell = (UIScreen.main.bounds.width - spacing * 3) / 2
        return CGSize(width: widthCell, height: UIScreen.main.bounds.height/2)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailMovie", sender: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let identifier = "\(index)" as NSString
        return UIContextMenuConfiguration(
            identifier: identifier,
            previewProvider: nil) { _ in
            let deleteAction = UIAction(
                title: NSLocalizedString("delete", comment: ""),
                image: UIImage(systemName: "trash")) { _ in
                self.deleteItem(at: indexPath)
            }
                let menu = [deleteAction]
            return UIMenu(title: "", image: nil, children: menu)
        }
    }

    func deleteItem(at indexPath: IndexPath) {
        let delay = 0.4
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.watchListCollectionView.performBatchUpdates({
                let watchList = self.watchListModel.watchListCellModels[indexPath.item].watchList
                self.watchListModel.watchListCellModels.remove(at: indexPath.item)
                self.coreDataManager.deleteMovieInWatchList(movieCoreData: watchList)
                self.watchListCollectionView.deleteItems(at: [indexPath])
                self.updateUI()
            })
        }
    }
}
