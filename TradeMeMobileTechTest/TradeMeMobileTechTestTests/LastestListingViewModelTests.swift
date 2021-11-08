//
//  LastestListingViewModelTests.swift
//  TradeMeMobileTechTestTests
//
//  Created by David Hillman on 9/11/21.
//

import XCTest
@testable import TradeMeMobileTechTest

class LastestListingViewModelTests: XCTestCase {

    private var stubApiService: StubApiService!
    private var subject: LatestListingsViewModel!
    
    override func setUp() {
        super.setUp()
        stubApiService = StubApiService()
        subject = LatestListingsViewModel(apiService: stubApiService)
    }

    
    override func tearDown() {
        subject = nil
        stubApiService = nil
        super.tearDown()
    }
    
    func createListing() -> Listing {
        return Listing(id: 1,
                       title: "This",
                       region: "That",
                       isBuyNowOnly: false,
                       hasBuyNow: false,
                       buyNowPrice: 2.0,
                       priceDisplay: "$303",
                       startingPrice: 1.0,
                       imageUrlString: "url")
    }
    
    func testRefreshDataSuccess() throws {
        
        var resultingState: LoadingState?
        let expectation = XCTestExpectation(description: "Has completed reqest")
        stubApiService.listings = [createListing()]
        subject.boundViewControllerDataUpdate = { state in
            
            resultingState = state
            XCTAssertNotNil(resultingState, "No data was downloaded.")
            expectation.fulfill()
        }
        subject.refreshData()
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(resultingState, .success([createListing()]))
    }
    
    func testRefreshDataLoading() throws {
        
        var resultingState: LoadingState?
        let expectation = XCTestExpectation(description: "Has completed reqest")
        subject.boundViewControllerDataUpdate = { state in
            
            resultingState = state
            XCTAssertNotNil(resultingState, "No data was downloaded.")
            expectation.fulfill()
        }
        subject.refreshData()
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(resultingState, .loading)
    }
    
    func testRefreshDataError() throws {
        
        var resultingState: LoadingState?
        let expectation = XCTestExpectation(description: "Has completed reqest")
        stubApiService.error = NSError(domain: "This", code: 1, userInfo: [:])
        subject.boundViewControllerDataUpdate = { state in
            
            resultingState = state
            XCTAssertNotNil(resultingState, "No data was downloaded.")
            expectation.fulfill()
        }
        subject.refreshData()
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(resultingState, .error(NSError(domain: "This", code: 1, userInfo: [:])))
    }
}
