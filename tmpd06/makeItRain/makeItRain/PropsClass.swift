//
//  PropsClass.swift
//  makeItRain
//
//  Created by Felicien Renaud on 02/04/2019.
//  Copyright © 2019 Felicien Renaud. All rights reserved.
//

import UIKit

class PropsClass: UIView {

    var size : CGFloat = 100
    var doCircle: Bool = false
    var shapeColor : UIColor?
    
    init(coordinates: CGPoint, maxWidth: CGFloat, maxHeight: CGFloat) {
        var x = coordinates.x
        var y = coordinates.y
        
        /* Empeche les formes d'avoir une taille superieur au cadre */
        if (x + (size / 2)) > maxWidth {
            x = x - (size / 2)
        } else if (y + (size / 2) > maxHeight) {
            y = y - (size / 2)
        }
        
        let gamble = Int(arc4random_uniform(2))
        switch gamble {
        case 0:
            super.init(frame: CGRect(x: x, y: y, width: size, height: size))
        default:
        super.init(frame: CGRect(x: x, y: y, width: size, height: size))
        self.layer.cornerRadius = size / 2
        doCircle = true
        }
        getShapeBackgroundColor()
    }
    
    func getShapeBackgroundColor() {
        let randomRed:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        shapeColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
