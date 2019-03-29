//
//  CustomTableViewCell.swift
//  Tweet42
//
//  Created by Felicien Renaud on 29/03/2019.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
