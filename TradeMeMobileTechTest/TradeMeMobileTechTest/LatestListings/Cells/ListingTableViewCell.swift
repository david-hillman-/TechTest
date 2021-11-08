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
    @IBOutlet weak var leftPriceLabel: UILabel! {
        didSet {
            leftPriceLabel.font = .systemFont(ofSize: 12)
            leftPriceLabel.textColor = .textDark
        }
    }
    @IBOutlet weak var rightPriceLabel: UILabel! {
        didSet {
            rightPriceLabel.font = .systemFont(ofSize: 12)
            rightPriceLabel.textColor = .textDark
        }
    }
    @IBOutlet weak var heroImageView: UIImageView!
    
    override func prepareForReuse() {
        
        regionLabel.text = ""
        titleLabel.text = ""
        leftPriceLabel.text = ""
        rightPriceLabel.text = ""
        heroImageView.image = nil
    }
}
