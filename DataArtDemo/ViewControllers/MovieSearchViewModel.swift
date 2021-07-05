//
//  MovieSearchViewModel.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 29/6/21.
//

import UIKit

final class MovieSearchViewModel {
    
    private let movieService: ConnectionMoviesProtocol
    
    // MARK: - Init
    init(movieService: ConnectionMoviesProtocol = ConnectionManagerMovies()) {
        self.movieService = movieService
    }
    
    // MARK: - Public Functions
    func searchMovies(input: String, completion :@escaping ([Movie]) -> ()) {
        movieService.searchMovies(text: input) { error, movies in
            completion(movies)
        }
    }
}
