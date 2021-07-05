//
//  MovieDetailViewModelTests.swift
//  DataArtDemoTests
//
//  Created by Diego Quimbo on 4/7/21.
//

import XCTest
@testable import DataArtDemo

class MovieDetailViewModelTests: XCTestCase {
    var viewModel: MovieDetailViewModel!
    var mockViewModel: MovieDetailViewModel!
    var mockMovieService: MockMovieService!
    
    override func setUp() {
        let movie: Movie = .init(id: 508943, name: "Movie1", overview: nil, imagePath: nil, category: .popular)
        mockMovieService = MockMovieService()
        
        viewModel = .init(movie: movie)
        mockViewModel = .init(movie: movie, movieService: mockMovieService)
    }
    
    func testServiceLoadVideos() {
        let expectation = self.expectation(description: "Get Videos")
        
        viewModel.getVideosFromAPI { error in
            XCTAssertNil(error)
            XCTAssertFalse(self.viewModel.movieVideos.isEmpty)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMockLoadVideos() {
        let expectation = self.expectation(description: "Get Movie Videos")
        
        mockViewModel.getVideosFromAPI { error in
            XCTAssertNil(error)
            XCTAssertFalse(self.mockViewModel.movieVideos.isEmpty)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
}
