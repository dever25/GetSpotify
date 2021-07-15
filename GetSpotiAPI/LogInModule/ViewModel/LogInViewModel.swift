//
//  LogInViewModel.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 14.07.2021.
//

import AuthenticationServices
import Foundation

final class LogInViewModel: NSObject, LogInViewModelProtocol, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    private let client = APIClient(configuration: URLSessionConfiguration.default)
    
    // MARK: - Get Spotify Access Code
    func logIn() {
//        guard let urlRequest = client.getSpotifyAccessCodeURL() else {
//            print("Error get urlRequest")
//            return
//        }
        let urlRequest = client.getSpotifyAccessCodeURL()
        
        let scheme = "auth"
        let session = ASWebAuthenticationSession(url: urlRequest, callbackURLScheme: scheme) { (callbackURL, error) in
            guard error == nil, let callbackURL = callbackURL else { return }
            
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            guard let requestAccessCode = queryItems?.first(where: { $0.name == "code" })?.value else { return }
            print(" Code \(requestAccessCode)")
            
            self.client.call(request: .accessCodeToAccessToken(code: requestAccessCode, completion: { (token) in
                switch token {
                case .failure(let error):
                    print(error)
                case .success(let token):
                    // TODO: - не безопасно
                    UserDefaults.standard.set(token.accessToken, forKey: "token")
                    UserDefaults.standard.set(token.refreshToken, forKey: "refresh_token")
                }
            }))
        }
        
        session.presentationContextProvider = self
        session.start()
    }
}
