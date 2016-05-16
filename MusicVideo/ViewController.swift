//
//  ViewController.swift
//  MusicVideo
//
//  Created by Diego Russo on 15/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

