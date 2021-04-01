//
//  MovieListResponseRequest.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import Foundation

struct MovieListResponseRequest: Decodable {
    var page: Int
    var movies: [Movie]
    var totalPages: Int
    var totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
