
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
    
    var movies: [Movie] = []
    
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
        
        MovieApiManager().findMovie(id: 284053){ (movies: [Movie]?, error: Error?) in
            if let movies = movies{
                self.movies = movies
                self.collectionView.reloadData()
                print(movies)
            }else{
                print(error?.localizedDescription)
            }
            
        }
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
        if let posterUrl = movie.posterUrl{
            print(posterUrl)
            cell.poster.af_setImage(withURL: posterUrl)
        }
        
        return cell
    }

   
}
