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
    var tweets : [TweetModel] = []
    let token : String
    
    init(delegate: APITwitterDelegate, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func requestTweet(query: String, nbOfTweet: Int) {
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let query = "https://api.twitter.com/1.1/search/tweets.json?q=\(encodedQuery)&count=\(nbOfTweet)&lang=fr&result_type=recent"
        let url = URL(string: query)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + self.token, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                DispatchQueue.main.async {
                    self.delegate?.tweetError(error: err as NSError)
                }
            }
            else if let d = data {
                do {
                    if let dict : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let tweets = dict.value(forKey: "statuses") as? [[String : AnyObject]] {
                            if tweets.count != 0 {
                                for tweet in tweets {
                                    let toProcess = tweet as NSDictionary
                                    let date = toProcess.value(forKey: "created_at") as! String
                                    let tweetToAdd = TweetModel(author: (toProcess.value(forKey: "user")! as AnyObject).value(forKey: "name")! as! String, tweetText: toProcess.value(forKey: "text") as! String, tweetDate: date)
                                    self.tweets.append(tweetToAdd)
                                }
                                DispatchQueue.main.async {
                                    self.delegate?.tweetHandler(tweetArray: self.tweets)
                                }
                            }
                        }
                    }
                } catch (let error) {
                    DispatchQueue.main.async {
                        self.delegate?.tweetError(error: error as NSError)
                    }
                }
            }
        }
        task.resume()
        print(self.tweets.description)
    }
}
