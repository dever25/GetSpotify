//
//  Constant.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

// TODO: - зашифровать
struct Constant {
    static let spotifyAPIClientID = "bd84a59ee78048e69047b55b208d6808"
    static let spotifyAPISecretKey = "c7796fda88ee47e6b3ccadb9ed2c6758"
    static let redirectURI = "GetSpotiAPI://callback"
    static let scope = ["user-read-email", "user-top-read"]
    static let responseType = "code"
}
