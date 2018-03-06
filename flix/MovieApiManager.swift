//
//  MovieApiManager.swift
//  flix
//
//  Created by ARG Lab on 3/2/18.
//  Copyright © 2018 ARG Lab. All rights reserved.
//

import Foundation

class MovieApiManager {
    enum lang: String {
        case en = "&language=en-US&page=1"
    }
    
    enum theMovieDB : String {
        case nowPlaying = "now_playing?"
        case popular = "popular?"
        
    }
    
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let language : lang = lang.en
    
    
    var session : URLSession
    
    init() {
        //creates a session to recieve the data from the server
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func findMovie(id: Int, completion: @escaping ([Movie]?, Error?) -> ()){
        // converts string to s a url
        let url = URL(string: MovieApiManager.baseUrl + "\(id)/similar?" + "api_key=\(MovieApiManager.apiKey)" + MovieApiManager.language.rawValue )!
        // creates a url request to be sent to a server
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        //recieves the data parses and stores it
        let task = session.dataTask(with: request){
            (data, response, error) in
            if let data = data{
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.movies(dictionaries: movieDictionaries)
                
                completion(movies, nil)
                
            }else if let error = error{
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func getMovie(movieType: theMovieDB ,completion: @escaping ([Movie]?, Error?) -> ()) {
        // converts string to s a url
        let url = URL(string: MovieApiManager.baseUrl + movieType.rawValue + "api_key=\(MovieApiManager.apiKey)" + MovieApiManager.language.rawValue )!
        // creates a url request to be sent to a server
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        //recieves the data parses and stores it
        let task = session.dataTask(with: request){
            (data, response, error) in
            if let data = data{
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.movies(dictionaries: movieDictionaries)
                
                completion(movies, nil)
                
            }else if let error = error{
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
}
