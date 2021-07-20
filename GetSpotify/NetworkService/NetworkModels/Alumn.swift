//
//  Playlists.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 17.07.2021.
//

import Foundation

struct Alumn: Model {
    let id: String
    let album: AlumnDetail?
    let artists: [Artist]
    let name: String
    let durationMs: Int?
    let previewUrl: URL?
    let images: [ArtistImage]?
}

struct AlumnDetail: Model {
    let name: String
    let images: [ArtistImage]
}

struct Artist: Model {
    let name: String
    let type: String
}
