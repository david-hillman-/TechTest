//
//  LatestListingsViewController.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import UIKit

final class LatestListingsViewController: UIViewController {
    
    enum AlertType: String {
        
        case cellTap = "Display action for cell tap",
             searchTap = "Display action for search tap",
             cartTap = "Display action for cart tap",
             error = "There was an error loading results"
    }
    
    @IBOutlet weak var listingTableView: UITableView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    var viewModel: LatestListingsViewModelProtocol
    
    init?(coder: NSCoder, viewModel: LatestListingsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateCurrentUI(state: .loading)
        viewModel.boundViewControllerDataUpdate = { state in
            self.updateCurrentUI(state: state)
        }
        viewModel.refreshData()
    }
    
    private func updateCurrentUI(state: LoadingState) {
        
        switch state {
        case .loading:
            listingTableView.isHidden = true
        case .success(_):
            listingTableView.isHidden = false
            listingTableView.reloadData()
        case .error(_):
            displayAlert(type: .error)
        }
    }
    
    private func displayAlert(type: AlertType) {
        
        let alertController = UIAlertController(title: "Alert", message: type.rawValue, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didTapSearchBarItem() {
        displayAlert(type: .searchTap)
    }
    
    @IBAction func didTapCartBarItem() {
        displayAlert(type: .cartTap)
    }
}

extension LatestListingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListingTableViewCell") as? ListingTableViewCell {
           let listing = viewModel.listings[indexPath.row]
            
            cell.regionLabel.text = listing.region
            cell.titleLabel.text = listing.title
            cell.currentPriceLabel.text = listing.priceDisplay
            
            if let buyNowPrice = listing.buyNowPrice {
                cell.buyNowPriceLabel.text = "\(buyNowPrice)"
            } else {
                cell.buyNowPriceLabel.text = ""
            }
            
            if let imageUrlString = listing.imageUrlString {
                cell.heroImageView.imageFromServerURL(imageUrlString, placeHolder: UIImage())
            } else {
                cell.heroImageView.image = nil
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension LatestListingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        displayAlert(type: .cellTap)
    }
}
