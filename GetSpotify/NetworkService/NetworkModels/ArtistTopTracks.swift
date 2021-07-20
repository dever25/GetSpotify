//
//  ArtistTopTracks.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 17.07.2021.
//

import Foundation

struct ArtistTopTracks: Model {
    let tracks: [ArtistTrack]
}

struct ArtistTrack: Model {
    let id: String
    let name: String
    let previewUrl: URL?
    let album: Alumn
}
