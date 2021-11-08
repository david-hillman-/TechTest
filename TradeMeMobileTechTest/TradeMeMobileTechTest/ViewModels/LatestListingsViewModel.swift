//
//  LatestListingsViewModel.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//


class LatestListingsViewModel {

    private var apiService: APIServiceProtocol!
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func refreshData() {
        
        apiService.getLatestListings { listings in
            
        }
    }
}
