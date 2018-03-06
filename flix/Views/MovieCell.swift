//
//  MovieCell.swift
//  flix
//
//  Created by ARG Lab on 1/27/18.
//  Copyright © 2018 ARG Lab. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var Cover: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Info: UILabel!
    
    var movie: Movie! {
        didSet{
            Title.text = movie.title
            Info.text = movie.overview
            Cover.af_setImage(withURL: movie.posterUrl!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
