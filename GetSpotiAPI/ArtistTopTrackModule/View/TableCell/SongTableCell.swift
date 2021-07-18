//
//  SongTableCell.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 18.07.2021.
//

import UIKit
import Kingfisher

class SongTableCell: TableCell {
    
    var simplifiedTrack: SimpleTrack!
    
    let artistLabel = UILabel()
    
    let playbackImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let playImage = UIImage(systemName: "play.fill")
        let playImageRed = playImage?.withTintColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), renderingMode: .alwaysOriginal)
        image.image = playImageRed
        return image
    }()
    
    lazy var hiddenPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    func playButtonTapped() {
        //TODO: сделать проигрывание
    }
    
    internal func setTrack(song: SimpleTrack) {
        simplifiedTrack = song
        configureCell()
        
        if song.previewUrl == nil {
            hiddenPlayButton.isHidden = true
            playbackImage.isHidden = true
        } else {
            hiddenPlayButton.isHidden = false
            playbackImage.isHidden = false
        }
        
        for image in song.images {
            cellImage.kf.setImage(with: image.url, completionHandler: { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    
                    DispatchQueue.main.async {
                        self.cellImage.image = value.image
                        self.label.text = song.title
                        self.artistLabel.text = song.artistName
                        
                    }
                }
            })
        }
    }
    
    override func configureCell() {
        super.configureCell()
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.font = UIFont.systemFont(ofSize: 11.5)
        artistLabel.textColor = .gray
        
        self.contentView.addSubview(artistLabel)
        self.contentView.addSubview(hiddenPlayButton)
        self.contentView.addSubview(playbackImage)
        
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            hiddenPlayButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            hiddenPlayButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            hiddenPlayButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            artistLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 2),
            artistLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 8),
            
            playbackImage.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            playbackImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor,
                                                  constant: -45),
            playbackImage.widthAnchor.constraint(equalTo: self.contentView.heightAnchor,
                                                 constant: -45),
            playbackImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    private func setPause() {
        let play = UIImage(systemName: "pause.fill")
        let playGray = play?.withTintColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), renderingMode: .alwaysOriginal)
        playbackImage.image = playGray
    }
    
    private func setPlay() {
        let play = UIImage(systemName: "play.fill")
        let playGray = play?.withTintColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), renderingMode: .alwaysOriginal)
        playbackImage.image = playGray
    }
}
