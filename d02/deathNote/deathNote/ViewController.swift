//
//  ViewController.swift
//  deathNote
//
//  Created by Felicien RENAUD on 1/9/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        self.addBasicDeath()
        self.tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    func addBasicDeath()
    {
        Death.add(name: "Alexandra Benalleau", description: "Manifeste pas contre Macron", date: "")
        Death.add(name: "Alexandre Benalla", description: "S'est casse le poignet en tapant sur Alexandra Benalleau", date: "")
        Death.add(name: "Emanuelle Macaron", description: "Empoisonne par Laduree", date: "")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Death.death.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.nameLabel.text = Death.death[indexPath.row].name
        cell.descriptionLabel.text = Death.death[indexPath.row].description
        cell.dateLabel.text = Death.death[indexPath.row].date
        return cell
    }
    
}

