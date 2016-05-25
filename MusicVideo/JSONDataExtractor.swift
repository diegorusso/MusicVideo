//
//  JSONDataExtractor.swift
//  MusicVideo
//
//  Created by Diego Russo on 25/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import Foundation

class JSONDataExtractor {
    
    static func extractVideoDataFromJson(videoDataObject: AnyObject) -> [Video] {
        
        // guard is like an assert: in this case we check if videoDataObject is a JSONDictionary. If so, we continue otherwise we return an empty array. videoData will be available in the entire function
        guard let videoData = videoDataObject as? JSONDictionary else { return [Video]()}
        
        var videos = [Video]()
        
        if let feeds = videoData["feed"] as? JSONDictionary, entries = feeds["entry"] as? JSONArray {
            for (index, data) in entries.enumerate(){
                var vName = "", vRights = "", vPrice = "", vImageUrl = "", vArtist = "", vVideoUrl = "", vImid = "", vGenre = "", vLinkToiTunes = "", vReleaseDate = ""
                
                // Video Name
                if let imName = data["im:name"] as? JSONDictionary,
                    label = imName["label"] as? String {
                    vName = label
                }
                
                // Video Rights
                if let rights = data["rights"] as? JSONDictionary,
                    label = rights["label"] as? String {
                    vRights = label
                }
                
                // Video Price
                if let imPrice = data["im:price"] as? JSONDictionary,
                    label = imPrice["label"] as? String {
                    vPrice = label
                }
                
                // Video Image
                if let imImage = data["im:image"] as? JSONArray,
                    image = imImage[2] as? JSONDictionary,
                    label = image["label"] as? String {
                    vImageUrl = label
                }
                
                // Video Artist
                if let imArtist = data["im:artist"] as? JSONDictionary,
                    label = imArtist["label"] as? String {
                    vArtist = label
                }
                
                // Video Url
                if let link = data["link"] as? JSONArray,
                    vUrl = link[1] as? JSONDictionary,
                    attributes = vUrl["attributes"] as? JSONDictionary,
                    href = attributes["href"] as? String {
                    vVideoUrl = href
                }
                
                // Video ID
                if let id = data["id"] as? JSONDictionary,
                    attributes = id["attributes"] as? JSONDictionary,
                    imId = attributes["im:id"] as? String {
                    vImid = imId
                }
                
                // Video Genre
                if let category = data["category"] as? JSONDictionary,
                    attributes = category["attributes"] as? JSONDictionary,
                    term = attributes["term"] as? String {
                    vGenre = term
                }
                
                // Video Link To iTunes
                if let id = data["id"] as? JSONDictionary,
                    label = id["label"] as? String {
                    vLinkToiTunes = label
                }
                
                // Video Release Date
                if let imReleaseDate = data["im:releaseDate"] as? JSONDictionary,
                    label = imReleaseDate["label"] as? String {
                    vReleaseDate = label
                }
                
                
                let currentVideo = Video(vRank: index+1, vName: vName, vRights: vRights, vPrice: vPrice, vImageUrl: vImageUrl, vArtist: vArtist, vVideoUrl: vVideoUrl, vImid: vImid, vGenre: vGenre, vLinkToiTunes: vLinkToiTunes, vReleaseDate: vReleaseDate)
                
                videos.append(currentVideo)
            }
        }
        return videos
    }
}
