//
//  FakeResponseData.swift
//  TMDB WatchlistTests
//
//  Created by Clément Martin on 01/04/2021.
//

import Foundation

class FakeResponseData {
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Data
    static var movieCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "movies", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static let movieIncorrectData = "erreur".data(using: .utf8)!
}

class TestError: Error {
    static let error = TestError()
}
