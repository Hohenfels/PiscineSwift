//
//  APIController.swift
//  Tweet42
//
//  Created by Felicien RENAUD on 3/28/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import Foundation

class APIController {
    
    weak var delegate: APITwitterDelegate?
    let token: String
    var tweets: [TweetModel] = []
    
    init(delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func appendTweets(_ dict : [[String: AnyObject]]) {
        for elem in dict {
            let tweet = elem as NSDictionary
            let date = tweet.value(forKey: "created_at") as! String
            let tmp = TweetModel(author: (tweet.value(forKey: "user")! as AnyObject).value(forKey: "name")! as! String,tweetText: tweet.value(forKey: "text")! as! String, tweetDate: date)
            self.tweets.append(tmp)
        }
        DispatchQueue.main.async {
            self.delegate!.tweetHandler(tweetArray: self.tweets)
        }
    }
    
    func twitterRequest(query: String) {
        self.tweets = []
        let encodedQuery = "https://api.twitter.com/1.1/search/tweets.json?q=\(query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)&lang=fr&count=100"
        let url = URL(string: encodedQuery)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + self.token,forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let err = error {
                DispatchQueue.main.async {
                    self.delegate?.tweetError(error: err as NSError)
                }
            }
            else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let tweets = dic.value(forKey: "statuses") as? [[String:AnyObject]] {
                            if tweets.count != 0 {
                                self.appendTweets(tweets)
                            }
                            else {
                                DispatchQueue.main.async {
                                    let err : NSError = NSError.init(domain: "Search Not Found", code: 1, userInfo: [:] )
                                    self.delegate?.tweetError(error: err)
                                }
                            }
                        }
                        else {
                            DispatchQueue.main.async {
                                let err : NSError = NSError.init(domain: "Missing search input", code: 1, userInfo: [:] )
                                self.delegate?.tweetError(error: err)
                            }
                        }
                        
                    }
                }
                catch (let err) {
                    DispatchQueue.main.async {
                        self.delegate?.tweetError(error: err as NSError)
                    }
                }
            }
        }
        task.resume()
    }
}
