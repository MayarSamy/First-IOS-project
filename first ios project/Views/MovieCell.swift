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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}