//
//  EndingPath.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

enum EndingPath {

    case token
    case userInfo

    func buildPath() -> String {
        switch self {
        case .token:
            return "token"
        case .userInfo:
            return "me"
        }
    }
}
