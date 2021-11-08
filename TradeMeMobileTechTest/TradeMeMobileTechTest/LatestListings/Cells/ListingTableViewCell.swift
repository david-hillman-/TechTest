//
//  ListingTableViewCell.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import UIKit

final class ListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var regionLabel: UILabel! {
        didSet {
            regionLabel.font = .systemFont(ofSize: 10)
            regionLabel.textColor = .textLight
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 12)
            titleLabel.textColor = .textDark
        }
    }
    @IBOutlet weak var buyNowPriceLabel: UILabel! {
        didSet {
            buyNowPriceLabel.font = .systemFont(ofSize: 12)
            buyNowPriceLabel.textColor = .textDark
        }
    }
    @IBOutlet weak var currentPriceLabel: UILabel! {
        didSet {
            currentPriceLabel.font = .systemFont(ofSize: 12)
            currentPriceLabel.textColor = .textDark
        }
    }
    @IBOutlet weak var heroImageView: UIImageView!
    
    override func prepareForReuse() {
        
        regionLabel.text = ""
        titleLabel.text = ""
        buyNowPriceLabel.text = ""
        currentPriceLabel.text = ""
        heroImageView.image = nil
    }
}
