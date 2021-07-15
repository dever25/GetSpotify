//
//  Client.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

struct APIClient {
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    func call(request: Request) {
        let urlRequest = request.builder.toURLRequest()
        session.dataTask(with: urlRequest) { (data, _, error) in
            let result: Result<Data, Error>
            
            if let error = error {
                result = .failure(error)
            } else {
                result = .success(data ?? Data())
            }
            
            DispatchQueue.main.async {
                request.completion(result)
            }
        }.resume()
    }
    
    internal func getSpotifyAccessCodeURL() -> URL {
        
        let paramDictionary = ["client_id": Constant.spotifyAPIClientID,
                               "redirect_uri": Constant.redirectURI,
                               "response_type": Constant.responseType,
                               "scope": Constant.scope.joined(separator: "%20")
        ]
        
        let mapToHTMLQuery = paramDictionary.map { key, value in
            return "\(key)=\(value)"
        }
        
        let stringQuery = mapToHTMLQuery.joined(separator: "&")
        let accessCodeBaseURL = "https://accounts.spotify.com/authorize"
        let fullURL = URL(string: accessCodeBaseURL.appending("?\(stringQuery)"))
        print(fullURL)
        return fullURL!
    }
}
