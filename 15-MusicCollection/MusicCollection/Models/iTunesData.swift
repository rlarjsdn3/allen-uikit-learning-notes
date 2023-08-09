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
    let albumName: String?
    let previewUrl: String?
    let imageUrl: String?
    private let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewUrl
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
}

extension Music {
    var releaseDateString: String {
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: isoDate)
        return dateString
    }
}
