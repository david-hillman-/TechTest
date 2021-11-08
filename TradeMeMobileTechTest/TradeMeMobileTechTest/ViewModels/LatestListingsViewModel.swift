//
//  LatestListingsViewModel.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import UIKit

protocol LatestListingsViewModelProtocol {
    
    func refreshData()
    var boundViewControllerDataUpdate : (() -> ()) { get set }
    var listings: [Listing]! { get }
}

class LatestListingsViewModel: LatestListingsViewModelProtocol {

    private var apiService: APIServiceProtocol!
    var boundViewControllerDataUpdate : (() -> ()) = {}
    var listings: [Listing]! {
        didSet {
            boundViewControllerDataUpdate()
        }
    }

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.listings = []
    }
    
    func bindViewControllerDataUpdate(updateEvent: @escaping (() -> ())) {
        boundViewControllerDataUpdate = updateEvent
    }
    
    func refreshData() {
        apiService.getLatestListings { [weak self] listings in
            
            guard let self = self else { return }
            self.listings = listings?.listings
        }
    }
}
