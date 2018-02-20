//
//  ViewController.swift
//  flix
//
//  Created by ARG Lab on 1/26/18.
//  Copyright © 2018 ARG Lab. All rights reserved.
//

import UIKit
import AlamofireImage



class ViewController: UIViewController , UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies : [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.startAnimating()
        tableView.dataSource = self
        // fetch movies from server
        fetchMovies()
        // pull to refresh implementation
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector( refreshControlAction(_ :)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl){
        
        fetchMovies()
        refreshControl.endRefreshing()
    }
    // table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.Title.text = title
        cell.Info.text = overview
        cell.Cover.backgroundColor = UIColor.blue
        
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        
        let coverImageUrl = URL(string: baseUrl + posterPath)
        
        cell.Cover.af_setImage(withURL: coverImageUrl!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
        
    }

    func fetchMovies() {
        // converts string to s a url
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1" )!
        // creates a url request to be sent to a server
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //creates a session to recieve the data from the server
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //recieves the data parses and stores it
        let task = session.dataTask(with: request){
            (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
            }else if let data = data{
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                //print(movies)
            }
        }
        task.resume()
    }


}

