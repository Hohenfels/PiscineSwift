//
//  DataImg.swift
//  APM
//
//  Created by Felicien RENAUD on 1/24/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import Foundation

enum DataImg : String
{
    case lowRes = "https://www.universetoday.com/wp-content/uploads/2012/02/583769main_GPM_Banner_1_800-600.jpg"
    case midRes = "https://www.toolfarm.com/images/uploads/blog2015-01/nasa_example1.jpg"
    case highRes = "https://www.numerama.com/content/uploads/2015/10/earth.jpg"
    case ultraRes = "https://wallpaperaccess.com/full/406893.jpg"
    
    static let allPics = [DataImg.lowRes, DataImg.midRes, DataImg.highRes, DataImg.ultraRes]
}
