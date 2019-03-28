//
//  ViewController.swift
//  Tweet42
//
//  Created by Felicien RENAUD on 3/27/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate {

    var delegate : APITwitterDelegate?
    var api : APIController?
    var tweets : [TweetModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        oauth()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func oauth() {
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        let bearer = ((TwitterKey.CONSUMER_KEY + ":" + TwitterKey.CONSUMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grand_type=client_credentials".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) { (response, data, error) in
            if let err = error {
                DispatchQueue.main.async {
                    self.delegate?.tweetError(error: err as NSError)
                }
            }
            else if let d = data {
                do {
                    print(d)
                } catch (let err) {
                    DispatchQueue.main.async {
                        self.delegate?.tweetError(error: err as NSError)
                    }
                }
            }
        }
        task.resume()
    }
    
    func tweetHandler(tweetArray: [TweetModel]) {
        self.tweets = tweetArray
    }
    
    func tweetError(error: NSError) {
        print(error)
    }
}

