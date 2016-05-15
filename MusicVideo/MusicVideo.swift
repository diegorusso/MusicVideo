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
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String
    
    var vImageData:NSData?
    
    // Getters
    var vName: String{
        return _vName
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImageUrl:String {
        return _vImageUrl
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDate: String {
        return _vReleaseDate
    }
    
    
    init(data: JSONDictionary){
        // We have to initialise all properties
        
        // Video Name
        if let name = data["im:name"] as? JSONDictionary,
            label = name["label"] as? String {
                _vName = label
        } else {
            // In case previous keys are not in data, _vName will be empty
            _vName = ""
        }
        
        // Video Rights
        if let rights = data["rights"] as? JSONDictionary,
            label = rights["label"] as? String {
                _vRights = label
        } else {
            _vRights = ""
        }
        
        // Video Price
        if let price = data["im:price"] as? JSONDictionary,
            label = price["label"] as? String {
                _vPrice = label
        } else {
            _vPrice = ""
        }
        
        // Video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            label = image["label"] as? String {
                _vImageUrl = label.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        // Video Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            label = artist["label"] as? String {
                _vArtist = label
        } else {
            _vArtist = ""
        }
        
        // Video Url
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            videoAttributes = vUrl["attributes"] as? JSONDictionary,
            videoHref = videoAttributes["href"] as? String {
                _vVideoUrl = videoHref
        } else {
            _vVideoUrl = ""
        }
        
        // Video ID
        if let id = data["id"] as? JSONDictionary,
            imidAttributes = id["attributes"] as? JSONDictionary,
            vImid = imidAttributes["im:id"] as? String {
                _vImid = vImid
        } else {
            _vImid = ""
        }
        
        // Video Genre
        if let category = data["category"] as? JSONDictionary,
            attributes = category["attributes"] as? JSONDictionary,
            vGenre = attributes["term"] as? String {
                _vGenre = vGenre
        } else {
            _vGenre = ""
        }
        
        // Video Link To iTunes
        if let id = data["id"] as? JSONDictionary,
            label = id["label"] as? String {
            _vLinkToiTunes = label
        } else {
            _vLinkToiTunes = ""
        }
        
        // Video Release Date
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary,
            label = releaseDate["label"] as? String {
            _vReleaseDate = label
        } else {
            _vReleaseDate = ""
        }
    }
}