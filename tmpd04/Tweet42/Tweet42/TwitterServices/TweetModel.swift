//
//  TweetModel.swift
//  Tweet42
//
//  Created by Felicien RENAUD on 3/27/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import Foundation

struct TweetModel: CustomStringConvertible {
    
    let author : String
    let tweetText : String
    let tweetDate : String
    
    init(author: String, tweetText: String, tweetDate: String) {
        self.author = author
        self.tweetText = tweetText
        self.tweetDate = tweetDate
    }
    
    var description: String {
        var description = ""
        description += "Author: \(self.author)\n"
        description += "Tweet content: \(self.tweetText)\n"
        description += "Tweet date: \(self.tweetDate)"
        return description
    }
}
