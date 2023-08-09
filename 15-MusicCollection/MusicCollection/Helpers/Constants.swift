//
//  Constants.swift
//  MusicCollection
//
//  Created by 김건우 on 2023/08/09.
//

import Foundation

// MARK: - NAME SPACE

// API호출을 위한 문자열 묶음
public struct MusicURL {
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "media=music"
    private init() { }
}

// 사용하겔 될 Cell 문자열 묶음
public struct Cell {
    static let musicCellIdentifier = "MusicTableViewCell"
    static let musicCollectionCellIdentifier = "MusicCollectionCellIdentifier"
    private init() { }
}

