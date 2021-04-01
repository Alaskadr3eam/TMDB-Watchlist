//
//  MockObject.swift
//  TMDB WatchlistTests
//
//  Created by Clément Martin on 01/04/2021.
//

import XCTest
@testable import TMDB_Watchlist

class MockObject {
    static func createMovieList() -> [Movie] {
        let movie = Movie(posterPath: nil,
                          adult: false,
                          overview: "test1",
                          releaseDate: "2020-07-09",
                          genreIds: [0],
                          id: 0,
                          originalTitle: "test1",
                          originalLanguage: "fr",
                          title: "test1",
                          backdropPath: nil,
                          popularity: 5.0,
                          voteCount: 1,
                          video: false,
                          voteAverage: 5.0)
        let movie1 = Movie(posterPath: nil,
                           adult: false,
                           overview: "test2",
                           releaseDate: "2020-07-09",
                           genreIds: [0],
                           id: 0,
                           originalTitle: "test2",
                           originalLanguage: "fr",
                           title: "test2",
                           backdropPath: nil,
                           popularity: 5.0,
                           voteCount: 1,
                           video: false,
                           voteAverage: 5.0)
        let movie2 = Movie(posterPath: nil,
                           adult: false,
                           overview: "test2",
                           releaseDate: "2020-07-09",
                           genreIds: [0],
                           id: 0,
                           originalTitle: "test2",
                           originalLanguage: "fr",
                           title: "test2",
                           backdropPath: nil,
                           popularity: 5.0,
                           voteCount: 1,
                           video: false,
                           voteAverage: 5.0)
        return [movie, movie1, movie2]
    }

    static func createMovie() -> Movie {
        let movie = Movie(posterPath: nil,
                          adult: false,
                          overview: "test1",
                          releaseDate: "2020-07-09",
                          genreIds: [0],
                          id: 0,
                          originalTitle: "test1",
                          originalLanguage: "fr",
                          title: "test1",
                          backdropPath: nil,
                          popularity: 5.0,
                          voteCount: 1,
                          video: false,
                          voteAverage: 5.0)
        return movie
    }
}
