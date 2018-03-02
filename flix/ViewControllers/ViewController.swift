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
    
    var movies : [Movie] = []
    
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
        
        cell.movie = movies[indexPath.row]
    
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
        MovieApiManager().getMovie(movieType: .nowPlaying, completion:{ (movies: [Movie]?, error: Error? ) in
            if let movies = movies{
                self.movies = movies
                self.tableView.reloadData()
            }
            })
    }


}

