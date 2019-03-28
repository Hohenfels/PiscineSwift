//
//  APITwitterDelegate.swift
//  Tweet42
//
//  Created by Felicien RENAUD on 3/28/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    
    func tweetHandler(tweetArray: [TweetModel])
    
    func tweetError(error: NSError)
}
