//
//  ViewController.swift
//  MusicVideo
//
//  Created by Diego Russo on 15/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos = [Video]()

    // Created pressing ctrl+dragging the label from Main.storyboard to here
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting this class as delegate for dataSource and delegate. This can be done also via GUI dragging the tableView to the controller and selecting dataSource/delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        // Just call it the first time
        reachabilityStatusChanged()
        
        // Call API
        let api = APIManager()
        let urlApi = "https://itunes.apple.com/uk/rss/topmusicvideos/limit=50/json"
        api.loadData(urlApi, completion: didLoadData)
    }
    
    func didLoadData(videos: [Video]) {
        
        self.videos = videos
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        tableView.reloadData()
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
    
    // Methods for the protocols UITableViewDataSource, UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        return cell
    
    }
}
