//
//  Movie.swift
//  flix
//
//  Created by ARG Lab on 3/2/18.
//  Copyright © 2018 ARG Lab. All rights reserved.
//

import Foundation

class Movie {
    var title : String
    var posterUrl: URL?
    var backDropUrl: URL?
    var overview: String
    var releaseDate: String
    
    
    init(dictionary: [String: Any]) {
        
        title = dictionary["title"] as? String ?? "No Title"
        let posterPath = dictionary["poster_path"] as! String
        let backDropPath = dictionary["backdrop_path"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        posterUrl = URL(string: baseUrl + posterPath)
        backDropUrl = URL(string: baseUrl + backDropPath)
        overview = dictionary["overview"] as! String
        releaseDate =  dictionary["release_date"] as! String
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie]{
        var movies: [Movie] = []
        for dictionary in dictionaries{
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
    
}








