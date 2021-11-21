//
//  Header.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

enum Header {
    case GETHeader(accessTokeny: String)
    case POSTHeader

    func buildHeader() -> [String: String] {
        switch self {
        case .GETHeader(let accessToken):
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(accessToken)"
            ]
        case .POSTHeader:
            // Spotify's required format for authorization
            guard let dataUTF8 = (Constant.spotifyAPIClientID + ":"
                                  + Constant.spotifyAPISecretKey).data(using: .utf8) else {
                print("Error: don't get buildHeader")
                return [:]
            }
            let spotifyAPIAuthKey = "Basic \(dataUTF8.base64EncodedString())"
            return ["Authorization": spotifyAPIAuthKey,
                    "Content-Type": "application/x-www-form-urlencoded"]
        }
    }
}
