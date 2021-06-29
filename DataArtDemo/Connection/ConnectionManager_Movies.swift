//
//  ConnectionManager_Movies.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import Alamofire
import SwiftyJSON

class ConnectionManager_Movies: ConnectionManager {
    
    class func getMovies(category: MovieCategory, completion :@escaping (_ error: Error?, _ movies: [Movie]) -> ()) {
        AF.request(URLs.Movie.getMovies(category: category), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    var movies: [Movie] = []
                    let moviesJson = JSON(data)["results"].array ?? []
                    for movieJson in moviesJson {
                        let movie = Movie(jsonObject: movieJson, category: category)
                        movies.append(movie)
                    }
                                    
                    completion(nil, movies)
                case .failure(let error):
                    completion(error, [])
                }
            }
    }
    
    class func getMovieVideos(movieID: Int, completion :@escaping (_ error: Error?, _ videos: [MovieVideo]) -> ()) {
        AF.request(URLs.Movie.getMovieVideos(movieId: movieID), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    var videos: [MovieVideo] = []
                    let videosJson = JSON(data)["results"].array ?? []
                    for videoJson in videosJson {
                        let video = MovieVideo(jsonObject: videoJson)
                        videos.append(video)
                    }
                                 
                    // Filter videos, show only Youtube videos
                    let filteredVideos = videos.filter { $0.site == .youtube}
                    
                    completion(nil, filteredVideos)
                case .failure(let error):
                    completion(error, [])
                }
            }
    }
    
    class func searchMovies(text: String, completion :@escaping (_ error: Error?, _ movies: [Movie]) -> ()) {
        AF.request(URLs.Movie.searchMovies(text: text), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    var movies: [Movie] = []
                    let moviesJson = JSON(data)["results"].array ?? []
                    for movieJson in moviesJson {
                        let movie = Movie(jsonObject: movieJson)
                        movies.append(movie)
                    }
                    
                    completion(nil, movies)
                case .failure(let error):
                    completion(error, [])
                }
            }
    }
}
