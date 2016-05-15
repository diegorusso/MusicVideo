//
//  APIManager.swift
//  MusicVideo
//
//  Created by Diego Russo on 15/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import Foundation

class APIManager{

    func loadData(urlString: String, completion: (result:String)-> Void){
        
        // An ephemeral session has no persistent disk storage for cookies,
        // cache or credentials.
        // let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        // let session = NSURLSession(configuration: config)
        
        // Singleton disegn pattern
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        // Async communication call in background thread
        // Started in suspended state
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            // Move everything back to the main thread
            dispatch_async(dispatch_get_main_queue()){
                if error != nil {
                    completion(result: (error!.localizedDescription))
                } else {
                    completion(result: "NSURLSession successful")
                    print(data)
                }
            }
        }
        // It executes the background process
        task.resume()
    }
}
