//
//  Extensions.swift
//  TradeMeMobileTechTest
//
//  Created by David Hillman on 8/11/21.
//

import UIKit

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.image = nil
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data, let downloadedImage = UIImage(data: data) {
                        self.image = downloadedImage
                    }
                }
            }).resume()
        }
    }
}

extension UIColor {
    
    static let feijoa = UIColor(named: "Feijoa 500")
    static let tasman = UIColor(named: "Tasman500")
    static let textDark = UIColor(named: "Text dark - Bluff Oyster 800")
    static let textLight = UIColor(named: "Test light - Bluff Oyster 600")
}
