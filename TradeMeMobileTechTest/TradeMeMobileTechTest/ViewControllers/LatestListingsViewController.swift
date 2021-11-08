//
//  LatestListingsViewController.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import UIKit

extension UIColor {
    static let feijoa = UIColor(named: "Feijoa 500")
    static let tasman = UIColor(named: "Tasman500")
    
    static let textDark = UIColor(named: "Text dark - Bluff Oyster 800")
    static let textLight = UIColor(named: "Test light - Bluff Oyster 600")
}

enum AlertType: String {
    
    case cellTap = "Display action for cell tap",
         searchTap = "Display action for search tap",
         cartTap = "Display action for cart tap"
}

final class LatestListingsViewController: UIViewController {
    
    @IBOutlet weak var listingTableView: UITableView!
    
    var api: APIServiceProtocol?
    var viewModel: LatestListingsViewModelProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        api = APIService()
        viewModel = LatestListingsViewModel(apiService: api!)
        viewModel?.boundViewControllerDataUpdate = {
            self.updateCurrentUI()
        }
        viewModel?.refreshData()
    }
    
    private func updateCurrentUI() {
        DispatchQueue.main.async {
            self.listingTableView.reloadData()
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
        viewModel?.listings.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListingTableViewCell") as? ListingTableViewCell,
           let listing = viewModel?.listings[indexPath.row] {
            
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
