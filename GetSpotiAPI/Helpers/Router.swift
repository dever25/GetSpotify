//
//  Router.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 16.07.2021.
//
import UIKit

class Router {
    
    // TODO: - изменить
    static let shared = Router()
    
    private init() {}
    
    func presentTopArtistVC() {
        let myTopArtistVC = TopArtistViewController(nibName: "TopArtistViewController", bundle: nil)
        myTopArtistVC.modalPresentationStyle = .fullScreen
        let model = TopArtistModel()
        let viewModel = TopArtistViewModel(artists: model)
        myTopArtistVC.viewModel = viewModel
        
        guard let topVC = UIWindow.getTopViewController() else {
            return
        }
        
        topVC.present(myTopArtistVC, animated: true)
    }
    
    func presentArtistTopTracksVC(artist: ArtistItem) {
        let tracksArtistVC = ArtistTopTracksVC(nibName: "ArtistTopTracksVC", bundle: nil)
        tracksArtistVC.modalPresentationStyle = .fullScreen
        let viewModel = ArtistTopTracksViewModel(artist: artist)
        tracksArtistVC.viewModel = viewModel
        
        guard let topVC = UIWindow.getTopViewController() else {
            return
        }
        topVC.present(tracksArtistVC, animated: true)
    }
    
    func back() {
        guard let topVC = UIWindow.getTopViewController() else {
            return
        }
        topVC.dismiss(animated: true)
    }
}
