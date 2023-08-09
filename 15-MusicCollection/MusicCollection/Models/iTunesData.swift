//
//  iTunesData.swift
//  MusicCollection
//
//  Created by 김건우 on 2023/08/09.
//

import Foundation

struct iTunesData: Codable {
    let resultCount: Int
    let results: [Music]
}

struct Music: Codable {
    let songName: String?
    let artistName: String?
    let previewUrl: String?
    let artworkUrl100: String?
    private let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case previewUrl
        case artworkUrl100
        case releaseDate
    }
}
