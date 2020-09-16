//
//  MediaCell.swift
//  first ios project
//
//  Created by IOS on 9/8/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import UIView_Shake

class MediaCell: UITableViewCell {
    
    @IBOutlet weak var mediaArtWork: UIImageView!
    @IBOutlet weak var mediaName: UILabel!
    @IBOutlet weak var mediaDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func artWorkBtnTapped(_ sender: UIButton) {
//        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, animations: ({
//            self.mediaArtWork.center.x = self.frame.width / 2
//        }), completion: nil)
        
        mediaArtWork.shake(10,              // 10 times
            withDelta: 6.0,  // 6 points wide
            speed: 0.1,     // 1s per shake
            shakeDirection: ShakeDirection.horizontal
        )
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
