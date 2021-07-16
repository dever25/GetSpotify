//
//  ArtistTableCell.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 16.07.2021.
//

import Foundation
import Kingfisher

class ArtistTableCell: TableCell {
    internal func setArtist(artist: ArtistItem) {
        configureCell()
        
        cellImage.kf.setImage(with: artist.images.first?.url, options: [], completionHandler: { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.label.text = artist.name
                    self.cellImage.image = value.image
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
