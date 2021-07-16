//
//  TopTracks.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 16.07.2021.
//

import Foundation

struct UserTopArtists: Model {
    let items: [ArtistItem]
}

struct ArtistItem: Model {
    let id: String
    let name: String
    let images: [ArtistImage]
}

struct ArtistImage: Model {
    let height: Int
    let url: URL
}

