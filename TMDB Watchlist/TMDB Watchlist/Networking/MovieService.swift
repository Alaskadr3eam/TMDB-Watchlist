//
//  MovieService.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import Foundation
import UIKit

class MovieService {

    private var movieSession = URLSession(configuration: .default)

    init(movieSession: URLSession) {
        self.movieSession = movieSession
    }

    var task: URLSessionDataTask?

    private var arguments: [String: String] =
        ["api_key": Constant.apiKey,
         "language": Constant.lang ?? Constant.langDefault,
         "page": String()]

    func getMovie(page: String, completionHandler: @escaping([Movie]?, NetworkError?) -> Void) {
        arguments["page"] = page
        guard var request = ServiceCreateRequest.createRequest(url: Constant.baseUrl,
                                                               arguments: arguments) else {
            return
        }
        request.httpMethod = "GET"
        task?.cancel()
        task = movieSession.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, NetworkError.errorFromAPI)
                }
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completionHandler(nil, NetworkError.badResponse)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, NetworkError.emptyData)
                }
                return
            }
            guard let moviesData = try? JSONDecoder().decode(MovieListResponseRequest.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(nil, NetworkError.jsonDecodeFailed)
                }
                return
            }
            DispatchQueue.main.async {
                let movies = moviesData.movies
                completionHandler(movies, nil)
            }
        }
        task?.resume()
    }
}
