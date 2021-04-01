//
//  Cell.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import UIKit

class WatchListCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!

    var model: WatchListCellModel! {
        didSet {
            configureCell()
        }
    }

    override func prepareForReuse() {
        self.posterImage.image = nil
        self.contentView.backgroundColor = .white
    }

    func configureCell() {
        addCornerRadiusContainView()
        self.titleLabel.text = self.model.name
        self.dateLabel.textColor = .darkGray
        self.dateLabel.text = self.model.date
        self.posterImage.image = self.model.imageData
    }

    private func addCornerRadiusContainView() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
