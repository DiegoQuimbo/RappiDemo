//
//  MoviesViewModel.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import Foundation
import PromiseKit

final class MoviesViewModel {
    
    // Private properties
    private let movieService: ConnectionMoviesProtocol
    private var _popularMovies: [Movie] = []
    private var _topRatedMovies: [Movie] = []
    private var _upcomingMovies: [Movie] = []
    private var _movieSelected: Movie?
    
    // MARK: - Init
    init(movieService: ConnectionMoviesProtocol = ConnectionManagerMovies()) {
        self.movieService = movieService
    }
    
    // MARK: - Public Functions
    func getPopularMovies() -> [Movie] {
        return _popularMovies
    }
    
    func getTopRatedMovies() -> [Movie] {
        return _topRatedMovies
    }
    
    func getUpcomingMovies() -> [Movie] {
        return _upcomingMovies
    }
    
    func shouldHideCategoryView(category: MovieCategory) -> Bool {
        switch category {
        case .popular:
            return _popularMovies.isEmpty
        case .topRated:
            return _topRatedMovies.isEmpty
        case .upcoming:
            return _upcomingMovies.isEmpty
        }
    }
    
    func setMovieSelected(movie: Movie) {
        _movieSelected = movie
    }
    
    func buildMovieDetailViewModel() -> MovieDetailViewModel? {
        guard let movie = _movieSelected else {
            return nil
        }
        return MovieDetailViewModel(movie: movie)
    }
    
    func loadMovies(completion: @escaping (Error?) -> ()) {
        if ConnectionManager.hasConnectivity() {
            getMoviesFromAPI(completion: completion)
        } else {
            getMoviesFromCoreData(completion: completion)
        }
    }
}

// MARK: - Private Functions
private extension MoviesViewModel {
    func getMoviesFromAPI(completion: @escaping (Error?) -> ()) {
        // Get movies async using PromiseKit
        firstly {
            when(fulfilled:
                 self.getMovieBy(category: .popular),
                 self.getMovieBy(category: .topRated),
                 self.getMovieBy(category: .upcoming))
        }.done { [weak self] popularMovies, topRatedMovies, upcomingMovies in
            // Throw error only in the case that all request failed
            if popularMovies.error != nil && topRatedMovies.error != nil && upcomingMovies.error != nil {
                completion(popularMovies.error)
                return
            }
            
            self?._popularMovies = popularMovies.movies
            self?._topRatedMovies = topRatedMovies.movies
            self?._upcomingMovies = upcomingMovies.movies
            
            // Save Movies in Core Data in order to show them whitout internet connection
            let allMovies = [popularMovies.movies, topRatedMovies.movies, upcomingMovies.movies].reduce([],+)
            Utilities.saveMoviesInCoreData(movies: allMovies)
            
            completion(nil)
        }.catch { error in
            completion(error)
        }
    }
    
    func getMovieBy(category: MovieCategory) -> Promise<(error: Error?, movies: [Movie])> {
        return Promise { movies in
            movieService.getMovies(category: category) {error, items  in
                movies.fulfill((error, items))
            }
        }
    }
    
    func getMoviesFromCoreData(completion: @escaping (Error?) -> ()) {
        let moviesSaved = Utilities.getMoviesSaved()
        _popularMovies = moviesSaved.filter{ $0.category == .popular }
        _topRatedMovies = moviesSaved.filter{ $0.category == .topRated }
        _upcomingMovies = moviesSaved.filter{ $0.category == .upcoming }
        
        completion(nil)
    }
}
