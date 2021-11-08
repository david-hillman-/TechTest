//
//  Network.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import Foundation

struct LatestListings: Decodable {
    let totalCount: Int
    let listings: [Listing]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case listings = "List"
    }
}

// MARK: - EmployeeData
struct Listing: Decodable {
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id = "ListingId"
        case title = "Title"
    }
}

protocol APIServiceProtocol {
    
    func getLatestListings(completion: @escaping (LatestListings?) -> ())
}

class APIService: APIServiceProtocol {
    
    private let sourcesURL = URL(string: "https://api.tmsandbox.co.nz/v1/listings/latest.json?rows=20")!

    
    func getLatestListings(completion: @escaping (LatestListings?) -> ()){
        
        let authString = "OAuth oauth_consumer_key=A1AC63F0332A131A78FAC304D007E7D1,oauth_signature_method=PLAINTEXT,oauth_signature=EC7F18B17A062962C6930A8AE88B16C7%26"
        
        
        var request = URLRequest(url: sourcesURL)
        request.addValue(authString, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            
            if let data = data {
                let decoder = JSONDecoder()

                do {
                    let list = try decoder.decode(LatestListings.self, from: data)
                    completion(list)
                } catch {
                    print(String(describing: error))
                }
            }
        }.resume()
    }
}
