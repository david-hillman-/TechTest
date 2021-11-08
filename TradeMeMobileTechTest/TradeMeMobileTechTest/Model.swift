//
//  Model.swift
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

struct Listing: Decodable {
    let id: Int
    let title: String
    let region: String
    let isBuyNowOnly: Bool?
    let isClassified: Bool?
    let hasBuyNow: Bool?
    let buyNowPrice: Double?
    let priceDisplay: String?
    let startingPrice: Double?
    let imageUrlString: String?

    enum CodingKeys: String, CodingKey {
        case id = "ListingId"
        case title = "Title"
        case region = "Region"
        case isBuyNowOnly = "IsBuyNowOnly"
        case isClassified = "IsClassified"
        case hasBuyNow = "HasBuyNow"
        case buyNowPrice = "BuyNowPrice"
        case priceDisplay = "PriceDisplay"
        case startingPrice = "StartPrice"
        case imageUrlString = "PictureHref"
    }
}
