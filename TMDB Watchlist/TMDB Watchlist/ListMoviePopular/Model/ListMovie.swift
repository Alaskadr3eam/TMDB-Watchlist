//
//  ListMovie.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import Foundation

protocol ListMovieDelegate {
    func weReceiveWeatherData()
    func failReceiveWeatherData(error: NetworkError)
}

class ListMovie {

    var moviesListCellModels: [MovieCellModel]

    private var movieServiceSession = MovieService(movieSession: URLSession(configuration: .default))

    var delegate: ListMovieDelegate?

    deinit {}

    init(movieServiceSession: MovieService) {
        self.movieServiceSession = movieServiceSession
        self.moviesListCellModels = []
    }
    // MARK: - Function Success
    fileprivate func success(_ responseMovies: [Movie]) {
        if self.moviesListCellModels.count != 0 {
            let newMovieCell = responseMovies.map { MovieCellModel(movie: $0) }
            newMovieCell.forEach { self.moviesListCellModels.append($0) }
        } else {
            self.moviesListCellModels = responseMovies.map { MovieCellModel(movie: $0) }
        }
        self.moviesListCellModels.sort { $0.name.lowercased() < $1.name.lowercased() }
        DispatchQueue.main.async {
            self.delegate?.weReceiveWeatherData()
        }
    }
    // MARK: - Function Failure
    fileprivate func failure(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.delegate?.failReceiveWeatherData(error: error)
        }
    }
    // MARK: - Request List Movie
    func getPopularMovieList(page: String, completionHandler: @escaping(Bool?) -> Void) {
        movieServiceSession.getMovie(page: page) { [weak self] (movies, error) in
            guard let self = self else { return }
            guard error == nil else {
                self.failure(error!)
                completionHandler(false)
                return
            }
            guard let movies = movies else {
                return
            }
            self.success(movies)
            completionHandler(true)
        }
    }

    // MARK: - Helpers
    func prepareNumberPageForRequest() {
        guard let page = Int(Constant.page) else { return }
        var pageNext = page
        pageNext += 1

        Constant.page = String(pageNext)
    }

    func movieListCell(at index: Int) -> MovieCellModel {
        self.moviesListCellModels[index]
    }
}
