//
//  AudioPlayer.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 19.07.2021.
//

import AVFoundation
import Foundation

class AudioPlayer {
    
    static let shared = AudioPlayer()
    var player: AVAudioPlayer?
    
    func downloadFileFromURL(url: URL) {
        URLSession.shared.downloadTask(with: url, completionHandler: { [weak self] (URL, _, _) in
            if let url = URL {
                self?.play(url: url)
            }
        }).resume()
    }
    
    func play(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch (let error) {
                print(error.localizedDescription)
            }
            player?.play()
            player?.volume = 0.7
            
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    func stop() {
        player?.stop()
    }
}
