//
//  ViewController.swift
//  MusicVideo
//
//  Created by Diego Russo on 15/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Created pressing ctrl+dragging the label from Main.storyboard to here
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        // Just call it the first time
        reachabilityStatusChanged()
        
        // Call API
        let api = APIManager()
        let urlApi = "https://itunes.apple.com/uk/rss/topmusicvideos/limit=10/json"
        api.loadData(urlApi, completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]) {
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
//        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
//        
//        let okAction = UIAlertAction(title: "Ok", style: .Default){ action -> Void in
//            //do something if you want
//        }
//        
//        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true, completion:nil)
        
    }
    
    // method to execute every time the ReachStatusChanged notification is received
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI:
            view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN:
            view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable with Cellular"
        default:
            return
        }
    }
    
    // It is called just as the object  is about to be deallocated
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    
    }
}

