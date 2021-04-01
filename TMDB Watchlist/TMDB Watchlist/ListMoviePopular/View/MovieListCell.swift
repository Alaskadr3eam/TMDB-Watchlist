//
//  MovieCell.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var model: MovieCellModel! {
        didSet {
            configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addMoficationLayer()
    }

    override func prepareForReuse() {
        self.posterImage.image = nil
        self.contentView.backgroundColor = .white
    }

    func configureCell() {
        self.titleLabel.text = self.model.name
        self.dateLabel.textColor = .darkGray
        self.dateLabel.text = self.model.date
        updateImage(posterImg: self.model.image)
        starImage.isHidden = !model.isWatchList
    }

    private func addMoficationLayer() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }

    private func updateImage(posterImg: String?) {
        guard let posterStringURL = posterImg else { return }
        let stringUrlImage = Constant.baseUrlStringImage + posterStringURL
        guard let posterImgUrl = URL(string: stringUrlImage) else {
            self.posterImage.image = UIImage(named: "noImage")
            return
        }
        DispatchQueue.main.async {
            self.fetchImageDataFrom(url: posterImgUrl)
        }
    }
    var task: URLSessionDataTask?
    var imageSession = URLSession(configuration: .default)
    // UI Views update
    private func fetchImageDataFrom(url: URL) {
        self.activityIndicatorView.isHidden = false
        self.posterImage.isHidden = true
        self.activityIndicatorView.startAnimating()
        task?.cancel()
        task = imageSession.dataTask(with: url) { (data, response, error) in

                    if let error = error {
                        DispatchQueue.main.async {
                            self.activityIndicatorView.isHidden = true
                            self.posterImage.isHidden = false
                            self.activityIndicatorView.stopAnimating()
                            self.posterImage.image = UIImage(named: "noImage")
                            print("Datatask error: \(error.localizedDescription)")
                        }
                        return
                    }

                    guard let data = data else {
                        DispatchQueue.main.async {
                        self.activityIndicatorView.isHidden = true
                        self.posterImage.isHidden = false
                        self.activityIndicatorView.stopAnimating()
                        self.posterImage.image = UIImage(named: "noImage")
                        print("Data is empty")
                        }
                        return
                    }

                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            self.activityIndicatorView.isHidden = true
                            self.posterImage.isHidden = false
                            self.activityIndicatorView.stopAnimating()
                            self.posterImage.image = image
                        }
                    }
                }
        task?.resume()
            }
}
