//
//  RequestBuilder.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

public enum HTTPMethod: String {
    case get, post, put, delete
}

protocol RequestBuilder {
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var baseURL: String { get }
    var path: String { get }
    var params: [String: Any]? { get }
    
    func toURLRequest() -> URLRequest?
}

extension RequestBuilder {
    
    func toURLRequest() -> URLRequest? {
        
        guard let fullURL = URL(string: baseURL + path) else {
            return nil
        }
        var request = URLRequest(url: fullURL)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        
        if let params = params,
           var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false) {
            components.queryItems = [URLQueryItem]()
            
            for (key, value) in params {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems?.append(queryItem)
            }
            request.url = components.url
        }
        return request
    }
}

struct BasicRequestBuilder: RequestBuilder {
    var method: HTTPMethod
    var headers: [String: String] = [:]
    var baseURL: String
    var path: String
    var params: [String: Any]?
}
