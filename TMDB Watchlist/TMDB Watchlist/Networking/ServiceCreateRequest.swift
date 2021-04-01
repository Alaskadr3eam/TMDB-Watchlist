//
//  ServiceCreateRequest.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import Foundation

struct ServiceCreateRequest {
    static func createRequest(url: URL, arguments: [String: String]) -> URLRequest? {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let param = arguments
        for (key, value) in param {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponents?.queryItems = items
        let urlComplete = urlComponents?.url
        guard let urlSecure = urlComplete else { return nil }
        let request = URLRequest(url: urlSecure)
        return request
    }
}
