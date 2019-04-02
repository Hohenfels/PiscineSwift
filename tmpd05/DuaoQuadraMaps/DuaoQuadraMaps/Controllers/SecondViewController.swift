//
//  SecondViewController.swift
//  DuaoQuadraMaps
//
//  Created by Felicien Renaud on 02/04/2019.
//  Copyright © 2019 Felicien Renaud. All rights reserved.
//

import UIKit

protocol LocationDelegate {
    func setMarks(locations: [Location])
    func updateLocation(location: Location)
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var locations : [Location] = []
    var delegate : LocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        loadLocations()
        delegate?.setMarks(locations: locations)
    }

    func loadLocations() {
        locations.append(Location(name: "42", description: "L'école de la seconde chansse", longitude: 2.318512, latitude: 48.896804))
        locations.append(Location(name: "Notre-Dame de Paris", description: "Monument historique", longitude: 2.349945, latitude: 48.853166))
        locations.append(Location(name: "Arc de Triomphe", description: "Monument historique", longitude: 2.295006, latitude: 48.874010))
        locations.append(Location(name: "Jardin du Luxembourg", description: "Il est jolie mon parc", longitude: 2.337289, latitude: 48.846426))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomTableViewCell
        cell.locationLabel.text = locations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.updateLocation(location: locations[indexPath.row])
        tabBarController?.selectedViewController = tabBarController?.viewControllers?.first
    }
}

