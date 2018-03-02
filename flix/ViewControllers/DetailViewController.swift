//
//  DetailViewController.swift
//  flix
//
//  Created by ARG Lab on 2/5/18.
//  Copyright © 2018 ARG Lab. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var backDrop: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var details: UILabel!
    
    var movie : Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
            self.titleLabel.text = movie.title
            self.date.text = movie.releaseDate
            self.details.text = movie.overview
        
            backDrop.af_setImage(withURL: movie.backDropUrl!)
            poster.af_setImage(withURL: movie.posterUrl!)
        
    }
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
