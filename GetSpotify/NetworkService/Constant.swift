//
//  Constant.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

// TODO: - зашифровать
struct Constant {
    static let spotifyAPIClientID = "1f56f3180c6945ef892f4f5f05d36f6a"
    static let spotifyAPISecretKey = "b110d2e6c49b4cc38b01ce68021801d0"
    static let redirectURI = "GetSpotify://callback"
    static let scope = ["user-read-email", "user-top-read"]
    static let responseType = "code"
}
