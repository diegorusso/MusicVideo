//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Diego Russo on 15/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import Foundation

class Videos{
    
    // Data Encapsulation - available within the class
    
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    
    // Getters
    
    var vName: String{
        return _vName
    }
    
    var vImageUrl:String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionary){
        // We have to initialise all properties
        
        // Video Name
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
                self._vName = vName
        } else {
            // In case previous keys are not in data, _vName will be empty
            _vName = ""
        }
        
        // Video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
            _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        // Video Url
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                _vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
        
        
    }
}