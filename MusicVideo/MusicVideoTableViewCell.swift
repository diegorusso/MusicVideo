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
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            print("Getting data from array...")
            musicImage.image = UIImage(data: video!.vImageData!)
        } else {
            GetVideoImage(video!, imageView: musicImage)
        }
        
    }
    
    
    func GetVideoImage(video: Videos, imageView: UIImageView){
        // This happens in a separate thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            // move back to the main Queue
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
            }
        }
    }
}
