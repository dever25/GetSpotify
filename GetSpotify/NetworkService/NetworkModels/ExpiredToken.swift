//
//  File.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 17.07.2021.
//

import Foundation

struct ExpireToken: Model {
    let error: ErrorMessage
}

struct ErrorMessage: Model {
    let status: Int?
    let message: String?
}
