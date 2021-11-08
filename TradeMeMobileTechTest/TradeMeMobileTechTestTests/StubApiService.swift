//
//  StubApiService.swift
//  TradeMeMobileTechTestTests
//
//  Created by David Hillman on 9/11/21.
//

import Foundation
@testable import TradeMeMobileTechTest

final class StubApiService: APIServiceProtocol {
    
    var listings = [Listing]()
    var error: Error?
    
    func getLatestListings(completion: @escaping (LoadingState) -> ()) {
        
        if let error = error {
            completion(.error(error))
            return
        }
        
        if listings.isEmpty {
            completion(.loading)
            return
        }
        
        completion(.success(listings))
    }
}
