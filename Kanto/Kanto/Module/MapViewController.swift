//
//  MapViewController.swift
//  Kanto
//
//  Created by Kateryna Zakharchuk on 08.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit
import Foundation
import MapKit

fileprivate enum MapModes: Int {
    case standart = 0
    case satelite = 1
    case hybrid = 2
    
    func number() -> Int {
        return self.rawValue
    }
}

struct Locale {
    static var coortinates: CLLocationCoordinate2D?
    static var title: String?
    static var subtitle: String?
}

class ColorPointAnnotation: MKPointAnnotation {
    var color: UIColor!
}

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentControlButtons: UISegmentedControl!
    
    let locationManager = CLLocationManager()
    private let colors: [UIColor] = [.blue, .red, .green, .black, .purple, .lightGray, .yellow, .brown, .gray]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeMapMode()
        
        if let coortinates = Locale.coortinates {
            setupCoordinates(coortinates)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Locale.coortinates = nil
        Locale.title = nil
        Locale.subtitle = nil
    }
    
    func setupCoordinates(_ coortinates: CLLocationCoordinate2D, _ hidePin: Bool = false) {
        
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegion(center: coortinates, span: span)
        mapView.setRegion(region, animated: true)
        
        if !hidePin {
            let dropPin = ColorPointAnnotation()
            dropPin.coordinate = coortinates
            dropPin.title = Locale.title
            dropPin.subtitle = Locale.subtitle
            dropPin.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            mapView.addAnnotation(dropPin)
        }
    }
    
    @IBAction func touchSecmentControlButton(_ sender: UISegmentedControl) {
        changeMapMode()
    }
    
    @IBAction func touchGoalButton(_ sender: UIButton) {
        var currentLocation: CLLocation!
        
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            
            currentLocation = locationManager.location
        }
        
        Locale.coortinates = currentLocation.coordinate
        Locale.title = "Hello"
        Locale.subtitle = "You are here :)"
        setupCoordinates(currentLocation.coordinate, true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        if let pin = annotation as? ColorPointAnnotation {
            
            let identifier = "pinAnnotation"
            
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                annotationView.pinTintColor = pin.color
                return annotationView
            } else {
                let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                annotationView.pinTintColor = pin.color
                return annotationView
            }
        }
        return nil
    }
    
    func changeMapMode() {
        
        switch segmentControlButtons.selectedSegmentIndex {
        case MapModes.standart.number():
            mapView.mapType = .standard
        case MapModes.satelite.number():
            mapView.mapType = .satellite
        case MapModes.hybrid.number():
            mapView.mapType = .hybrid
        default:
            break
        }
    }
}

