//
//  Parameters.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

enum Parameters {
    case codeForToken(accessCode: String)
    case refreshTokenForAccessCode(refreshToken: String)
    case timeRange(range: String)

    func buildParameters() -> [String: Any] {
        switch self {
        case .codeForToken(let code):
            return ["grant_type": "authorization_code",
                    "code": "\(code)",
                    "redirect_uri": Constant.redirectURI]
        case .refreshTokenForAccessCode(let refreshToken):
            return ["grant_type": "refresh_token",
                    "refresh_token": refreshToken
            ]
        case .timeRange(let range):
            return ["time_range": range]
        }
    }
}
