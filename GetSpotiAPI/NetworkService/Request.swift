//
//  Request.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 15.07.2021.
//

import Foundation

struct Request {
    let builder: RequestBuilder
    let completion: (Result<Data, Error>) -> Void
    
    private static func buildRequest(method: HTTPMethod,
                                     header: [String: String],
                                     baseURL: String, path: String,
                                     params: [String: Any]? = nil,
                                    completion: @escaping (Result<Data, Error>) -> Void) -> Request {
        
        let builder = BasicRequestBuilder(method: method, headers: header, baseURL: baseURL, path: path, params: params)
        
        return Request(builder: builder, completion: completion)
    }
}

extension Request {
    
    static func accessCodeToAccessToken(code: String,
                                        completion: @escaping (Result<Tokens, Error>) -> Void) -> Request {
        
        Request.buildRequest(method: .post,
                             header: Header.POSTHeader.buildHeader(),
                             baseURL: SpotifyBaseURL.authBaseURL.rawValue,
                             path: EndingPath.token.buildPath(),
                             params: Parameters.codeForToken(accessCode: code).buildParameters()) { (result) in
                                
                                result.decoding(Tokens.self, completion: completion)
        }
    }
}

public extension Result where Success == Data, Failure == Error {
    
    func decoding<M: Model>(_ model: M.Type,
                            completion: @escaping (Result<M, Error>) -> Void) {
        
        DispatchQueue.global().async {
            let result = self.flatMap { data -> Result<M, Error> in
                do {
                    let decoder = M.decoder
                    let model = try decoder.decode(M.self, from: data)
                    return .success(model)
                } catch {
                    return .failure(error)
                }
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
