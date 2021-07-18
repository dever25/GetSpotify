//
//  ArtistTopTracksViewModel.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 18.07.2021.
//

import Foundation

class ArtistTopTracksViewModel: ArtistTopTracksViewModelProtocol {
    
    var title: String {
        artist.name
    }
    
    var simplifiedTracks = [SimpleTrack]()
    
    private var artist: ArtistItem
    private let client = APIClient(configuration: URLSessionConfiguration.default)
    
    init(artist: ArtistItem) {
        self.artist = artist
    }
    
    func back() {
        Router.shared.back()
    }
    
    func fetchArtistTopTracks(completion: @escaping () -> Void) {
        guard let token = (UserDefaults.standard.string(forKey: "token")) else {
            return
        }
        
        client.call(request: .getArtistTopTracks(id: artist.id, token: token, completions: { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let tracks):
                for track in tracks.tracks {
                    let newTrack = SimpleTrack(artistName: track.album.artists.first?.name,
                                               id: track.id,
                                               title: track.name,
                                               previewURL: track.previewUrl,
                                               images: track.album.images!)
                    self.simplifiedTracks.append(newTrack)
                }
                completion()
            }
        }))
    }
}
