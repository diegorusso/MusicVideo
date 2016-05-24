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
    
    var video: Video? {
        didSet{
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell(){
        
        // This is needed to adapt fonts to system size (from accessibility)
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            print("Getting data from array...")
            musicImage.image = UIImage(data: video!.vImageData!)
        } else {
            print("Getting images in background thread...")
            GetVideoImage(video!, imageView: musicImage)
        }
        
    }
    
    
    func GetVideoImage(video: Video, imageView: UIImageView){
        // This happens in a separate thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            
            let bestImage = NSUserDefaults.standardUserDefaults().boolForKey("BestImage")
            var vImageUrl: String
            
            if (bestImage && reachabilityStatus == WIFI){
                vImageUrl = video.vImageUrl.stringByReplacingOccurrencesOfString("100x100", withString: "900x900")
            } else {
                vImageUrl = video.vImageUrl.stringByReplacingOccurrencesOfString("100x100", withString: "200x200")
            }
            
            
            let data = NSData(contentsOfURL: NSURL(string: vImageUrl)!)
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
