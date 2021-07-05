//
//  MovieDetailViewModel.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//


final class MovieDetailViewModel {
    private let movieService: ConnectionMoviesProtocol
    private var _movie: Movie
    private var _movieVideos: [MovieVideo] = []
    private var _videoSelected: MovieVideo?
    
    // MARK: - Init
    init(movie: Movie, movieService: ConnectionMoviesProtocol = ConnectionManagerMovies()) {
        self._movie = movie
        self.movieService = movieService
    }
    
    // MARK: - Vars
    var title: String {
        return _movie.name ?? ""
    }
    
    var subtitle: String {
        return _movie.overview ?? ""
    }
    
    var movieVideos: [MovieVideo] {
        return _movieVideos
    }
    
    // MARK: - Public Functions
    func setVideoSelected(video: MovieVideo) {
        _videoSelected = video
    }
    
    func getVideoSelected() -> MovieVideo? {
        return _videoSelected
    }
    
    // MARK: - Call Network
    func getVideosFromAPI(completion :@escaping (Error?) -> ()) {
        // Check internet connection in order to avoid server call in case the device doesn't have internet
        if !ConnectionManager.hasConnectivity() {
            completion(nil)
            return
        }
        
        movieService.getMovieVideos(movieID: _movie.id) {[weak self] error, videos in
            self?._movieVideos = videos
            completion(error)
        }
    }
}
