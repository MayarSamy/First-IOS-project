//
//  MediaCell.swift
//  first ios project
//
//  Created by IOS on 9/8/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
    
    @IBOutlet weak var mediaArtWork: UIImageView!
    @IBOutlet weak var mediaName: UILabel!
    @IBOutlet weak var mediaDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
