//
//  Constants.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import Foundation

struct Constant {
    static let apiKey = "376d17d61e8a25929f3bceb4f40f22cc"
    static let baseUrlString = "https://api.themoviedb.org/3/movie/popular"
    static let baseUrlStringImage = "https://image.tmdb.org/t/p/w300"
    static let baseUrl = URL(string: "https://api.themoviedb.org/3/movie/popular")!
    static let numberOfMovie = 20
    static let lang = Locale.current.languageCode
    static let langDefault = "en-US"
    static var page = "1"
}
