//
//  MockMovieService.swift
//  DataArtDemoTests
//
//  Created by Diego Quimbo on 4/7/21.
//

import Foundation
@testable import DataArtDemo

final class MockMovieService: ConnectionMoviesProtocol {
    
    func getMovies(category: MovieCategory, completion: @escaping (Error?, [Movie]) -> ()) {
        let movie1: Movie = .init(id: 1, name: "Movie 1", overview: nil, imagePath: nil, category: category)
        let movie2: Movie = .init(id: 2, name: "Movie 2", overview: nil, imagePath: nil, category: category)
        let movie3: Movie = .init(id: 3, name: "Movie 3", overview: nil, imagePath: nil, category: category)
        
        completion(nil, [movie1, movie2, movie3])
    }
    
    func getMovieVideos(movieID: Int, completion: @escaping (Error?, [MovieVideo]) -> ()) {
        let movieVideo1: MovieVideo = .init(id: "1", key: nil, name: "Movie 1", site: .youtube)
        let movieVideo2: MovieVideo = .init(id: "1", key: nil, name: "Movie 1", site: .youtube)
        
        completion(nil, [movieVideo1, movieVideo2])
    }
    
    func searchMovies(text: String, completion: @escaping (Error?, [Movie]) -> ()) {
        let movie1: Movie = .init(id: 1, name: "Movie 1", overview: nil, imagePath: nil, category: .popular)
        let movie2: Movie = .init(id: 2, name: "Movie 2", overview: nil, imagePath: nil, category: .topRated)
        
        completion(nil, [movie1, movie2])
    }
}
