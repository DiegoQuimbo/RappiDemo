//
//  MovieSearchViewModel.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 29/6/21.
//

import UIKit

final class MovieSearchViewModel {
    
    // MARK: - Public Functions
    func searchMovies(input: String, completion :@escaping ([Movie]) -> ()) {
        ConnectionManager_Movies.searchMovies(text: input) { error, movies in
            completion(movies)
        }
    }
}
