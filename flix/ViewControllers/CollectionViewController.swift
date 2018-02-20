
//
//  CollectionCollectionViewController.swift
//  flix
//
//  Created by ARG Lab on 2/11/18.
//  Copyright © 2018 ARG Lab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate{
    
    var movies: [[String : Any ]] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        fetchHero()
        
        //print(movies)
    }
    
    func fetchHero() {
        // converts string to s a url
        let url = URL(string: "https://api.themoviedb.org/3/movie/284053/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1" )!
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
                self.collectionView.reloadData()
                
                print(movies)
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation


     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperHeroCell", for: indexPath) as! SuperheroCell
    
        // Configure the cell
        let movie = movies[indexPath.item]
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        
        let coverImageUrl = URL(string: baseUrl + posterPath)
        
        cell.poster.af_setImage(withURL: coverImageUrl!)
        
        return cell
    }

   
}
