//
//  URLs.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import Foundation

enum MovieCategory: String {
    case popular = "popular"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    
    var queryValue: String {
        switch self {
        case .popular: return "popular"
        case .topRated: return "top_rated"
        case .upcoming: return "upcoming"
        }
    }
    
    var title: String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        }
    }
}

struct URLs {
    
    static let apiKey = "c5f0d36d54bf603011c04fae58fdb2ed"
    static let baseURL : URL = URL(string: "https://api.themoviedb.org/3/")!
    
    struct Movie {
        static let imagesBaseURL = "https://image.tmdb.org/t/p/w500/"
        static let videoBaseURL = "https://www.youtube.com/watch?v="
        
        static func getMovies(category: MovieCategory) -> String {
            return "\(baseURL)movie/\(category.queryValue)?api_key=\(apiKey)&language=en-US".encodingQuery()
        }
        
        static func getMovieVideos(movieId: Int) -> String {
            return "\(baseURL)movie/\(movieId)/videos?api_key=\(apiKey)&language=en-US".encodingQuery()
        }
        
        static func searchMovies(text: String) -> String {
            return "\(baseURL)search/movie?api_key=\(apiKey)&language=en-US&query=\(text)".encodingQuery()
        }
    }
}
