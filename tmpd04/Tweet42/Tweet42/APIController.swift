//
//  APIController.swift
//  Tweet42
//
//  Created by Felicien RENAUD on 3/28/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import Foundation

class APIController {
    
    weak var delegate : APITwitterDelegate?
    let token : String
    
    init(delegate: APITwitterDelegate, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func requestTweet(query: String, nbOfTweet: Int) {
        var tweets: [TweetModel]
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let request = NSMutableURLRequest(url: URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(encodedQuery)&count=\(nbOfTweet)&lang=fr&result_type=recent")!)
        request.httpMethod = "GET"
        request.setValue("Bearer", forHTTPHeaderField: "Authorization")
        
    }
}
