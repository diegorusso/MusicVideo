//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Diego Russo on 20/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    
    // The logic to setup the cell should be in this class and nowhere else!

    var video: Videos? {
        didSet{
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell(){
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        musicImage.image = UIImage(named: "imageNotAvailable")
    
    }
    
}
