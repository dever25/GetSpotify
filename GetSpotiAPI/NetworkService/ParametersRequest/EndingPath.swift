//
//  EndingPath.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

enum EndingPath {

    case token
    case userInfo
    case artist(id: String)
    case artists(ids: [String])
    case artistTopTracks(artistId: String, country: Country)
    case search(term: String, type: SpotifyType)
    case myTop(type: MyTopType)
    case tracks(ids: [String])

    func buildPath() -> String {
        switch self {
        case .token:
            return "token"
        case .userInfo:
            return "me"
        case .artist(let id):
            return "artist/\(id)"
        case .artists(let ids):
            return "artists&ids=\(ids.joined(separator: ","))"
        case .search(let space, let type):
            let convertSpacesToProperURL = space.replacingOccurrences(of: " ", with: "%20")
            return "search?q=\(convertSpacesToProperURL)&type=\(type)"
        case .artistTopTracks(let id, let country):
            return "artists/\(id)/top-tracks?country=\(country)"
        case .myTop(let type):
            return "me/top/\(type)"
        case .tracks(let ids):
            return "tracks/?ids=\(ids.joined(separator: ","))"
        }
    }
}
