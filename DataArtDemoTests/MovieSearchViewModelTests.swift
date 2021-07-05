//
//  MovieSearchViewModelTests.swift
//  DataArtDemoTests
//
//  Created by Diego Quimbo on 4/7/21.
//

import XCTest
@testable import DataArtDemo

class MovieSearchViewModelTests: XCTestCase {
    var viewModel: MovieSearchViewModel!
    var mockViewModel: MovieSearchViewModel!
    var mockMovieService: MockMovieService!
    
    override func setUp() {
        viewModel = .init()
        mockMovieService = MockMovieService()
        mockViewModel = .init(movieService: mockMovieService)
    }
    
    func testServiceSearchMovies() {
        let expectation = self.expectation(description: "Search Movies")
        
        viewModel.searchMovies(input: "Luca") { movies in
            XCTAssertFalse(movies.isEmpty)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMockSearchMovies() {
        let expectation = self.expectation(description: "Search Movies")
        
        mockViewModel.searchMovies(input: "") { movies in
            XCTAssertFalse(movies.isEmpty)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
}
