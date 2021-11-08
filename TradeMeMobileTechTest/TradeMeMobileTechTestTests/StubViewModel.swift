//
//  StubViewModel.swift
//  TradeMeMobileTechTestTests
//
//  Created by David Hillman on 9/11/21.
//

import Foundation
@testable import TradeMeMobileTechTest

final class StubViewModel: LatestListingsViewModelProtocol {
    
    private var apiService: APIServiceProtocol!
    var boundViewControllerDataUpdate: ((_ state: LoadingState) -> Void) = {state in }
    var listings: [Listing] = []
    
    var refreshDataWasCalled = false
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func refreshData() {
        refreshDataWasCalled = true
    }
}
