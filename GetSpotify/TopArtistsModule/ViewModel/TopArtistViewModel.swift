//
//  TopArtistViewModel.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 16.07.2021.
//

import Foundation

class TopArtistViewModel: TopArtistViewModelProtocol {
    
    private lazy var token = (UserDefaults.standard.string(forKey: "token"))
    private let client = APIClient(configuration: URLSessionConfiguration.default)
    var artists = TopArtistModel()
    
    init(artists: TopArtistModel) {
        self.artists = artists
    }
    
    func getUserTopArtists(completion: @escaping () -> Void) {

    }
    
    func tabOnArtist(index: Int) {
        Router.shared.presentArtistTopTracksVC(artist: artists.items[index])
    }
}
