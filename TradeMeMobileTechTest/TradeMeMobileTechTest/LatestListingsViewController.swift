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
}

final class LatestListingsViewController: UIViewController {

    @IBOutlet weak var listingTableView: UITableView!
    
    var api: APIServiceProtocol?
    var viewModel: LatestListingsViewModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        api = APIService()
        viewModel = LatestListingsViewModel(apiService: api!)
        viewModel?.refreshData()
        // Do any additional setup after loading the view.
    }
}
