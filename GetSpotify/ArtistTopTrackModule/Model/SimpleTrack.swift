//
//  SimpleTrack.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 18.07.2021.
//

import Foundation

struct SimpleTrack {
    let id: String
    let artistName: String?
    let title: String
    let previewUrl: URL?
    let images: [ArtistImage]
    
    init(artistName: String?, id: String, title: String, previewURL: URL?, images: [ArtistImage]) {
        self.artistName = artistName
        self.id = id
        self.title = title
        self.previewUrl = previewURL
        self.images = images
    }
}
