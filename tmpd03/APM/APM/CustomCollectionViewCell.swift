//
//  CustomCollectionViewCell.swift
//  APM
//
//  Created by Felicien RENAUD on 1/24/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit
import Foundation


class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    public var shouldShowAlert : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func showActivityIndicator(activityIndicator status : Bool)
    {
        if status == true
        {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        else
        {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}
