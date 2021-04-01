//
//  Extension+DetailMovieViewController.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import UIKit

extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailMovie = self.detailMovieModel else { return  UICollectionViewCell() }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCenterCell",
                                                                    for: indexPath) as? LabelCenterCell else {
                    return UICollectionViewCell()
                }
                cell.label.textAlignment = .center
                cell.label.text = self.detailMovieModel?.date
                return cell
            } else if indexPath.row == 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCenterCell",
                                                                    for: indexPath) as? PictureCenterCell else {
                    return UICollectionViewCell()
                }
                cell.imageView.layer.cornerRadius = 20
                cell.imageView.image = self.detailMovieModel?.image
                return cell
            } else if indexPath.row == 2 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCenterCell",
                                                                    for: indexPath) as? LabelCenterCell else {
                    return UICollectionViewCell()
                }
                cell.label.text = detailMovie.synopsis
                return cell
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCenterCell",
                                                                    for: indexPath) as? LabelCenterCell else {
                    return UICollectionViewCell()
                }
                cell.label.textAlignment = .center
                cell.label.text = detailMovie.note
                return cell
            } else if indexPath.row == 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCenterCell",
                                                                    for: indexPath) as? ButtonCenterCell else {
                    return UICollectionViewCell()
                }
                cell.button.tintColor = detailMovie.isWatchList == true ? .systemYellow : .lightGray
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension DetailMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return CGSize(width: UIScreen.main.bounds.width, height: 20)
            } else if indexPath.row == 1 {
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            } else if indexPath.row == 2 {
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
            }
        case 1:
            if indexPath.row == 0 {
                return CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 40)
            } else if indexPath.row == 1 {
                return CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 40)
            }
        default:
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: 0, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
