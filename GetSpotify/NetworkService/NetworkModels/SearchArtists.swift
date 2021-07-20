//
//  SearchArtists.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 17.07.2021.
//

import Foundation

struct SearchArtists: Model {
    let artists: Artists
}

struct Artists: Model {
    let items: [ArtistItem]
}
