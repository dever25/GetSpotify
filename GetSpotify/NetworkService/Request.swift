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
    
    static func checkExpiredToken(token: String,
                                  completion: @escaping (Result<ExpireToken, Error>) -> Void) -> Request {
        
        Request.buildRequest(method: .get,
                             header: Header.GETHeader(accessTokeny: token).buildHeader(),
                             baseURL: SpotifyBaseURL.APICallBase.rawValue,
                             path: EndingPath.userInfo.buildPath()) { (result) in
                                
                                result.decoding(ExpireToken.self, completion: completion)
        }
    }
    
    static func refreshTokenToAccessToken(completion: @escaping (Result<Tokens, Error>) -> Void) -> Request? {
        
        guard let refreshToken = UserDefaults.standard.string(forKey: "refresh_token") else { return nil }
        
        let parameters = Parameters.buildParameters(.refreshTokenForAccessCode(refreshToken: refreshToken))()
        return Request.buildRequest(method: .post,
                                    header: Header.POSTHeader.buildHeader(),
                                    baseURL: SpotifyBaseURL.authBaseURL.rawValue,
                                    path: EndingPath.token.buildPath(),
                                    params: parameters) { result in
                                        // makeing decoding call
                                        result.decoding(Tokens.self, completion: completion)
        }
        
    }
    
    static func getUserTopArtists(token: String,
                                  completions: @escaping (Result<UserTopArtists, Error>) -> Void) -> Request {
        let apiClient = APIClient(configuration: URLSessionConfiguration.default)
        
        apiClient.call(request: .checkExpiredToken(token: token, completion: { (expiredToken) in
            switch expiredToken {
            case .failure:
                print("token still valid")
            case .success:
                print("token expired")
                apiClient.call(request: refreshTokenToAccessToken(completion: { (refreshToken) in
                    switch refreshToken {
                    case .failure:
                        print("no refresh token returned")
                    case .success(let refresh):
                        print(refresh.accessToken)
                        UserDefaults.standard.set(refresh.accessToken, forKey: "token")
                        apiClient.call(request: .getUserTopArtists(token: refresh.accessToken,
                                                                   completions: completions))
                    }
                })!)
            }
        }))
        
        return Request.buildRequest(method: .get,
                                    header: Header.GETHeader(accessTokeny: token).buildHeader(),
                                    baseURL: SpotifyBaseURL.APICallBase.rawValue,
                                    path: EndingPath.myTop(type: .artists).buildPath(),
                                    params: Parameters.timeRange(range: "long_term").buildParameters()) { (result) in
                                        result.decoding(UserTopArtists.self, completion: completions)
                                        
        }
        
    }
    
    static func getArtistTopTracks(id: String, token: String,
                                   completions: @escaping (Result<ArtistTopTracks, Error>) -> Void) -> Request {
        
                let apiClient = APIClient(configuration: URLSessionConfiguration.default)
        
                apiClient.call(request: .checkExpiredToken(token: token, completion: { (expiredToken) in
                    switch expiredToken {
                    case .failure:
                        print("token still valid")
                    case .success:
                        print("token expired")
                        apiClient.call(request: refreshTokenToAccessToken(completion: { (refreshToken) in
                            switch refreshToken {
                            case .failure:
                                print("no refresh token returned")
                            case .success(let refresh):
                                UserDefaults.standard.set(refresh.accessToken, forKey: "token")
                                apiClient.call(request: .getArtistTopTracks(id: id,
                                                                            token: refresh.accessToken,
                                                                            completions: completions))
                            }
                        })!)
                    }
                }))
        
        return Request.buildRequest(method: .get,
                                    header: Header.GETHeader(accessTokeny: token).buildHeader(),
                                    baseURL: SpotifyBaseURL.APICallBase.rawValue,
                                    path: EndingPath.artistTopTracks(artistId: id,
                                                                     country: .US ).buildPath()) { (result) in
                                        
                                        result.decoding(ArtistTopTracks.self, completion: completions)
        }
    }
    
    static func getUserInfo(token: String, completion: @escaping (Result<UserModel, Error>) -> Void) -> Request {
        
        Request.buildRequest(method: .get,
                             header: Header.GETHeader(accessTokeny: token).buildHeader(),
                             baseURL: SpotifyBaseURL.APICallBase.rawValue,
                             path: EndingPath.userInfo.buildPath()) { result in
                                
                                result.decoding(UserModel.self, completion: completion)
        }
    }
    
    static func search(token: String, term: String, type: SpotifyType, completion: @escaping (Any) -> Void) -> Request {
        Request.buildRequest(method: .get,
                             header: Header.GETHeader(accessTokeny: token).buildHeader(),
                             baseURL: SpotifyBaseURL.APICallBase.rawValue,
                             path: EndingPath.search(term: term, type: type).buildPath()) { (result) in
                                
                                switch type {
                                case .artist:
                                    result.decoding(SearchArtists.self, completion: completion)
                                case .track:
                                    result.decoding(SearchTracks.self, completion: completion)
                                default:
                                    print("this search type not implemented yet")
                                }
        }
  
    }
    
}

extension Result where Success == Data, Failure == Error {
    
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
