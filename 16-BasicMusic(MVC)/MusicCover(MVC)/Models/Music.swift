//
//  Music.swift
//  MusicCover(MVC)
//
//  Created by 김건우 on 2023/09/01.
//

import Foundation

struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

struct Music: Codable {
    let songName: String?
    let artistName: String?
    let albumName: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case imageUrl = "artworkUrl100"
    }
}
