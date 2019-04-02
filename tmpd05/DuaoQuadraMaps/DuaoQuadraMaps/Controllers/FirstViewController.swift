//
//  FirstViewController.swift
//  DuaoQuadraMaps
//
//  Created by Felicien Renaud on 02/04/2019.
//  Copyright © 2019 Felicien Renaud. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, LocationDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationHandler = CLLocationManager()
    var secondController : SecondViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        secondController = tabBarController?.viewControllers?[1] as! SecondViewController?
        secondController?.delegate = self
        locationHandler.delegate = self
        locationHandler.distanceFilter = 10
        locationHandler.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 48.896583, longitude: 2.318971)
        annotation.title = "Ecole 42"
        annotation.subtitle = "Ecole de la seconde Chansse"
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showLocation()
    }

    func showLocation() {
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .authorizedWhenInUse {
            locationHandler.startUpdatingLocation()
            mapView.showsUserLocation = true
        } else {
            locationHandler.requestWhenInUseAuthorization()
            showLocation()
        }
    }
    
    @IBAction func findMeButton(_ sender: UIButton) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: (locationHandler.location?.coordinate)!, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func mapViewSelection(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "mark"
        var markView: MKPinAnnotationView
        
        if let dequeueMarkView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeueMarkView.annotation = annotation
            markView = dequeueMarkView
        } else {
            markView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            markView.canShowCallout = true
        }
        if annotation.subtitle??.range(of:"historique") != nil {
            markView.pinTintColor = UIColor.red
        }
        else if annotation.subtitle??.range(of:"école") != nil {
            markView.pinTintColor = UIColor.blue
        }
        else if annotation.subtitle??.range(of:"parc") != nil {
            markView.pinTintColor = UIColor.green
        }
        return markView
    }
    
    func setMarks(locations: [Location]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            annotation.subtitle = location.desc
            mapView.addAnnotation(annotation)
        }
    }
    
    func updateLocation(location: Location) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        annotation.title = location.name
        annotation.subtitle = location.desc
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
}

