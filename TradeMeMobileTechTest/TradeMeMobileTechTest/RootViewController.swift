//
//  RootViewController.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 9/11/21.
//

import UIKit

class RootViewController: UIViewController {
    
    //DH:- Rootviewcontroller is here simply for dependancy injection, using storyboards there is a bug(feature) that neither the tabbarviewcontroller a navigation controller will recognise segue actions when creating the imbeded view controller.

    @IBSegueAction
    func makeLatestListingsViewController(coder: NSCoder) -> UIViewController? {
        let api = APIService()
        let viewModel = LatestListingsViewModel(apiService: api)
        
        return LatestListingsViewController(coder: coder, viewModel: viewModel)
    }
}
