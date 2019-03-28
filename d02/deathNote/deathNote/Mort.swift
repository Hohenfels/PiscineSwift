//
//  Mort.swift
//  deathNote
//
//  Created by Felicien RENAUD on 1/9/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import Foundation

typealias DeathData = (name: String, description: String, date: String)

class Death: NSObject {
    
    static var death : [DeathData] = []
    
    class func add(name: String, description: String, date: String)
    {
        let new: DeathData = (name: name, description: description, date: date)
        Death.death.append(new)
    }
}
