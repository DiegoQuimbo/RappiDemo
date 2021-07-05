//
//  MoviesViewModelTests.swift
//  DataArtDemoTests
//
//  Created by Diego Quimbo on 4/7/21.
//

import XCTest
@testable import DataArtDemo

class MoviesViewModelTests: XCTestCase {
    
    var viewModel: MoviesViewModel!
    var mockViewModel: MoviesViewModel!
    var mockMovieService: MockMovieService!
    
    override func setUp() {
        viewModel = .init()
        mockMovieService = MockMovieService()
        mockViewModel = .init(movieService: mockMovieService)
    }
    
    func testServiceLoadMovies() {
        let expectation = self.expectation(description: "Load Movies")
        
        viewModel.loadMovies { error in
            XCTAssertNil(error)
            XCTAssertFalse(self.viewModel.shouldHideCategoryView(category: .popular))
            XCTAssertFalse(self.viewModel.shouldHideCategoryView(category: .topRated))
            XCTAssertFalse(self.viewModel.shouldHideCategoryView(category: .upcoming))
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMockLoadMoviesWithValues() {
        let expectation = self.expectation(description: "Load Movies")
        
        mockViewModel.loadMovies { error in
            XCTAssertNil(error)
            XCTAssertFalse(self.mockViewModel.shouldHideCategoryView(category: .popular))
            XCTAssertFalse(self.mockViewModel.shouldHideCategoryView(category: .topRated))
            XCTAssertFalse(self.mockViewModel.shouldHideCategoryView(category: .upcoming))
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
}
