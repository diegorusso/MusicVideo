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
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        // Singleton disegn pattern
        //let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        // Async communication call in background thread
        // Started in suspended state
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil { // oops, there is an error
                dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                }
            } else { // OK, everything looks good
                // print(data)
                // JSONSerialization
                do {
                    /* .AllowFragments - top level object is not Array or Dictionary
                    Any type of string or value
                    NSJSONSerialization requires the Do / Try /Catch
                    Converts the NSDATA into a JSON Object and cast it to a Dictionary */
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject] {
                        
                        print(json)
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH //highest priority possible
                        dispatch_async(dispatch_get_global_queue(priority, 0)){
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(result: "JSONSerialization Successful")
                            }
                        }
                    }
                } catch {
                    dispatch_async(dispatch_get_main_queue()){
                        completion(result: "error in NSJSONSerialization")
                    }
                }
                // End of JSONSerialization
            }
        }
        // It executes the background process
        task.resume()
    }
}
