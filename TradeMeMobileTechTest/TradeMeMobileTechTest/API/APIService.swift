//
//  Network.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import Foundation

enum LoadingState: Equatable {
    
    case loading
    case success([Listing])
    case error(Error)
    
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        
        switch (lhs, rhs) {
        case ( .loading, .loading):
            return true
            
        case ( .success, .success):
            return true
            
        case (.error, .error):
            return true
            
        default:
            return false
        }
    }
}

struct APIUrlStrings {
    
    static let baseUrl = "https://api.tmsandbox.co.nz/v1/"
    static let listings = "listings/latest.json?"
}

// All params are hardcoded for the exercise

struct APIParams {
    
    static let rows = "rows=20"
}

struct APIAuthParams {
    
    static let consumer = "oauth_consumer_key=A1AC63F0332A131A78FAC304D007E7D1"
    static let method = "oauth_signature_method=PLAINTEXT"
    static let signature = "oauth_signature=EC7F18B17A062962C6930A8AE88B16C7%26"
}

protocol APIServiceProtocol {
    
    func getLatestListings(completion: @escaping (LoadingState) -> ())
}

final class APIService: APIServiceProtocol {
    
    func getLatestListings(completion: @escaping (LoadingState) -> ()){
        
        let authString = "OAuth \(APIAuthParams.consumer),\(APIAuthParams.method),\(APIAuthParams.signature)"
        guard let listingUrl = URL(string: APIUrlStrings.baseUrl + APIUrlStrings.listings + APIParams.rows) else { return }
        
        var request = URLRequest(url: listingUrl)
        request.addValue(authString, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            
            if let data = data {
                let decoder = JSONDecoder()

                do {
                    let list = try decoder.decode(LatestListings.self, from: data)
                    completion(.success(list.listings))
                } catch {
                    completion(.error(error))
                }
            }
        }.resume()
    }
}
