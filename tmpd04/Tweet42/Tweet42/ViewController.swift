//
//  ViewController.swift
//  Tweet42
//
//  Created by Felicien RENAUD on 3/27/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, APITwitterDelegate {


    @IBOutlet weak var tableView: UITableView!
    var delegate : APITwitterDelegate?
    var api : APIController?
    var tweets : [TweetModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        oauth()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func oauth() {
        let bearer = ((TwitterKey.CONSUMER_KEY + ":" + TwitterKey.CONSUMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let err = error {
                DispatchQueue.main.async {
                    self.delegate?.tweetError(error: err as NSError)
                }
            }
            else if let d = data {
                do {
                    if let dict: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        self.api = APIController.init(delegate: self.delegate!, token: dict.value(forKey: "access_token") as! String)
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
    
    func requestTweets(query: String) {
        self.tweets = []
        self.api?.twitterRequest(query: query)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        requestTweets(query: textField.text!)
        return true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomTableViewCell
        cell.authorLabel.text = tweets[indexPath.row].author
        cell.dateLabel.text =  String(tweets[indexPath.row].tweetDate.prefix(10))
        cell.messageLabel.text = tweets[indexPath.row].tweetText
        print(tweets[indexPath.row].description + "\n")
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tweetHandler(tweetArray: [TweetModel]) {
        self.tweets = tweetArray
        tableView.reloadData()
    }
    
    func tweetError(error: NSError) {
        let alertController = UIAlertController(title: "Error", message:error.localizedDescription , preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

