//
//  LatestListingsViewModel.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import UIKit


protocol LatestListingsViewModelProtocol {
    
    func refreshData()
    var boundViewControllerDataUpdate: ((_ state: LoadingState) -> Void) { get set }
    var listings: [Listing] { get }
}

final class LatestListingsViewModel: LatestListingsViewModelProtocol {
    
    private var apiService: APIServiceProtocol!
    var boundViewControllerDataUpdate: ((_ state: LoadingState) -> Void) = {state in }
    var listings: [Listing] = []
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func bindViewControllerDataUpdate(updateEvent: @escaping ((_ state: LoadingState) -> Void)) {
        boundViewControllerDataUpdate = updateEvent
    }
    
    func refreshData() {
        apiService.getLatestListings { [weak self] loadingState in
            
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch loadingState {
                case .unloaded, .loading:
                    self.boundViewControllerDataUpdate(.loading)
                case .success(let listings):
                    self.listings = listings
                    self.boundViewControllerDataUpdate(.success(listings))
                case .error(let error):
                    self.listings = []
                    print(String(describing: error))
                    self.boundViewControllerDataUpdate(.error(error))
                    
                }
            }
        }
    }
}
