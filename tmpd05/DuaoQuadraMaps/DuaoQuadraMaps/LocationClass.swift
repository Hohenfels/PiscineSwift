//
//  Locations.swift
//  DuaoQuadraMaps
//
//  Created by Felicien Renaud on 02/04/2019.
//  Copyright © 2019 Felicien Renaud. All rights reserved.
//

import Foundation

struct Location {
    
    let name : String
    let desc : String
    let longitude : Double
    let latitude : Double
    
    init(name: String, description: String, longitude: Double, latitude: Double) {
        self.name = name
        self.desc = description
        self.longitude = longitude
        self.latitude = latitude
    }
    
    var description : String {
        return "Location: \(name), \(desc)\n\tLONGITUDE: \(longitude)\n\tLATITUDE: \(latitude)"
    }
}
