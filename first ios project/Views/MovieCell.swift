//
//  MovieCell.swift
//  first ios project
//
//  Created by IOS on 8/26/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    //outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieTypeLbl: UILabel!
    @IBOutlet weak var moviesReleasedLbl: UILabel!
    @IBOutlet weak var movieRatingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
