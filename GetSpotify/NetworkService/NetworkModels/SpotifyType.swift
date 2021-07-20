//
//  SpotifyType.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 17.07.2021.
//

import Foundation

enum SpotifyType: String {
    case album = "ablum"
    case artist = "artist"
    case playlist = "playlist"
    case track = "track"
    case show = "show"
    case episode = "episode"
}

enum MyTopType: String {
    case tracks
    case artists
}

enum Country: String {
    case US
    case UK
}
