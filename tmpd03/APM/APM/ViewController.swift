//
//  ViewController.swift
//  APM
//
//  Created by Felicien RENAUD on 1/24/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout
    {
        let _flowLayout = UICollectionViewFlowLayout()
        
        _flowLayout.itemSize = CGSize(width: 160, height: 160)
        return _flowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(UINib.init(nibName : "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        self.collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool)
    {
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageSegue"
        {
            let dstVc = segue.destination as? ShowImageController
            let cell = sender as! CustomCollectionViewCell
            if let dst = dstVc
            {
                dst.photo = cell.imgView.image
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return DataImg.allPics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CustomCollectionViewCell
        let imageUrl = URL(string: DataImg.allPics[indexPath.row].rawValue)
        cell.showActivityIndicator(activityIndicator: true)
        URLSession.shared.dataTask(with: imageUrl!)
        {
            (data, response, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Woops !", message: "\(String(describing: error))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                if let httpResponse = response as? HTTPURLResponse
                {
                    if httpResponse.statusCode == 404
                    {
                        let alert = UIAlertController(title: "Woops !", message: "Error HTTP response code : \(httpResponse.statusCode) on URL : \(DataImg.allPics[indexPath.row].rawValue)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                DispatchQueue.main.async
                {
                    cell.imgView.image = UIImage(data: data!)
                    cell.showActivityIndicator(activityIndicator: false)
                }
            }.resume()
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showImageSegue", sender: collectionView.cellForItem(at: indexPath))
    }
    
}

