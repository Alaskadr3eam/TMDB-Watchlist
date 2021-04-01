//
//  MovieListTestCase.swift
//  TMDB WatchlistTests
//
//  Created by Clément Martin on 01/04/2021.
//

import XCTest
import CoreData
@testable import TMDB_Watchlist

class MovieListTestCase: XCTestCase {

    var movieList: ListMovie!

    override func setUp() {
        movieList = ListMovie(movieServiceSession: MovieService(movieSession: URLSession(configuration: .default)))
    }

    func testIncrementationPageForparametersRequestNext() {
        let page = Constant.page

        movieList.prepareNumberPageForRequest()

        XCTAssertNotEqual(page, Constant.page)
        guard var pageInt = Int(page) else { return }
        pageInt += 1
        let pageString = String(pageInt)
        XCTAssertEqual(Constant.page, pageString)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
