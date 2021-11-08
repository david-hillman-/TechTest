//
//  LatestListingsViewModel.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import UIKit

enum LoadingState<Data> {
  case unloaded
  case loading
  case success(Data)
  case error(Error)
}

protocol LatestListingsViewModelProtocol {
    
    func refreshData()
    var boundViewControllerDataUpdate: (() -> Void) { get set }
    var listings: [Listing] { get }
}

final class LatestListingsViewModel: LatestListingsViewModelProtocol {

    private var apiService: APIServiceProtocol!
    var boundViewControllerDataUpdate: (() -> Void) = {}
    var listings: [Listing] {
        didSet {
            boundViewControllerDataUpdate()
        }
    }

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.listings = []
    }
    
    func bindViewControllerDataUpdate(updateEvent: @escaping (() -> Void)) {
        boundViewControllerDataUpdate = updateEvent
    }
    
    func refreshData() {
        apiService.getLatestListings { [weak self] lastestListings in
            
            guard let self = self else { return }
            self.listings = lastestListings?.listings ?? []
        }
    }
}
