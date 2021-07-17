//
//  SearchTracks.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 17.07.2021.
//

import Foundation

struct SearchTracks: Model {
    let tracks: Tracks
}

struct Tracks: Model {
    let items: [ArtistTrack]
}
