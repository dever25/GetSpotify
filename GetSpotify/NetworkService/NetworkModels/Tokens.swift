//
//  Tokens.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//
import Foundation

struct Tokens: Model {
    let accessToken: String
    let expiresIn: Int
    let scope: String?
    let refreshToken: String?
}
