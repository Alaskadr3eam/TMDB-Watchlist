//
//  MovieServiceTest.swift
//  TMDB WatchlistTests
//
//  Created by Clément Martin on 01/04/2021.
//

import XCTest
@testable import TMDB_Watchlist

class MovieServiceTest: XCTestCase {
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let movieService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: TestError.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        movieService.getMovie(page: "1") { (movies, error) in
            // Then
            XCTAssertEqual(error, NetworkError.errorFromAPI)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let movieService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        movieService.getMovie(page: "1") { (movies, error) in
            // Then
            XCTAssertEqual(error, NetworkError.badResponse)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.movieCorrectData,
                                                                     response: FakeResponseData.responseKO,
                                                                     error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        movieService.getMovie(page: "1") { (movies, error) in
            //Then
            XCTAssertEqual(error, NetworkError.badResponse)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.movieIncorrectData,
                                                                     response: FakeResponseData.responseOK,
                                                                     error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        movieService.getMovie(page: "1") { (movies, error) in
            // Then
            XCTAssertEqual(error, NetworkError.jsonDecodeFailed)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.movieCorrectData,
                                                                     response: FakeResponseData.responseOK,
                                                                     error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        movieService.getMovie(page: "1") { (movies, error) in

            XCTAssertNil(error)
            XCTAssertEqual(movies?.first?.title, "Godzilla vs. Kong")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData2() {
        // Given
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.movieIncorrectData,
                                                                     response: FakeResponseData.responseOK,
                                                                     error: TestError.error))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        movieService.getMovie(page: "1") { (movies, error) in
            //XCTAssertEqual(FakeResponseData.weatherCorrectData, weatherData)
            XCTAssertNil(movies)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
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
