//
//  CustomTableViewCell.swift
//  DuaoQuadraMaps
//
//  Created by Felicien Renaud on 02/04/2019.
//  Copyright © 2019 Felicien Renaud. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
