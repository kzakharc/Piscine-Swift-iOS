//
//  MainViewController.swift
//  GPS
//
//  Created by Kateryna Zakharchuk on 10/14/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//


import UIKit
import MapKit
import GooglePlaces
import GoogleMaps

fileprivate enum MapModes: Int {
    case standart = 0
    case satelite = 1
    case hybrid = 2
    
    func number() -> Int {
        return self.rawValue
    }
}

fileprivate class Locale: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    var color: UIColor?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
}

fileprivate class ColorPointAnnotation: MKPointAnnotation {
    var color: UIColor!
}

fileprivate enum Location {
    case start
    case destination
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startLocation: UIButton!
    @IBOutlet weak var destinationLocation: UIButton!
    @IBOutlet weak var segmentControlButtons: UISegmentedControl!
    @IBOutlet weak var carOrWalkSegmentControl: UISegmentedControl!
    @IBOutlet var buttons: [UIButton]!
    
    fileprivate var selfLocation: MKCoordinateRegion?
    fileprivate var locationManager: CLLocationManager!
    fileprivate var locationSelected = Location.start
    
    fileprivate var startAnnonation: Locale?
    fileprivate var destinationAnnotation: Locale?
    
    fileprivate var locationStart = CLLocation()
    fileprivate var locationDestination = CLLocation()
    
    fileprivate var isBestRoute = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocationManager()
        mapView.showsUserLocation = true
        
        buttons.forEach { (button) in
            button.layer.borderWidth = 1
            button.layer.borderColor = button.backgroundColor?.cgColor
            button.layer.cornerRadius = 10
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeMapMode()
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
        setupCoordinates(currentLocation.coordinate)
    }
    
    func setupCoordinates(_ coortinates: CLLocationCoordinate2D) {
        
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegion(center: coortinates, span: span)
        mapView.setRegion(region, animated: true)
    }

    private func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    //function for create a marker pin on map
    private func createMarker(forLocation locaiton: Location, titleMarker title: String, subTitle: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        switch locaiton {
        case .start:
            startAnnonation = Locale(title: title, subtitle: subTitle, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            startAnnonation!.color = UIColor.blue
            mapView.addAnnotation(startAnnonation!)
        case .destination:
            destinationAnnotation = Locale(title: title, subtitle: subTitle, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            destinationAnnotation!.color = UIColor.red
            mapView.addAnnotation(destinationAnnotation!)
        }
    }
    
    //this is function for create direction path, from start location to desination location
    private func drawPath() {
        mapView.removeOverlays(mapView.overlays)
        let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: locationStart.coordinate.latitude, longitude: locationStart.coordinate.longitude))
        let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: locationDestination.coordinate.latitude, longitude: locationDestination.coordinate.longitude))
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        if carOrWalkSegmentControl.selectedSegmentIndex == 0 {
            directionRequest.transportType = .automobile
        } else {
            directionRequest.transportType = .walking
        }
        directionRequest.requestsAlternateRoutes = true
        
        let direcation = MKDirections(request: directionRequest)
        direcation.calculate { [weak self] response, error in
            if let _ = error {
                let alert = UIAlertController(title: "Notice", message: "Directions not Available!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self?.present(alert, animated: true, completion: nil)
                //Directions Not Available
                return }
            if let response = response {
                self?.isBestRoute = true
                for route in response.routes {
                    self?.mapView.add(route.polyline, level: .aboveLabels)
                    let rect = route.polyline.boundingMapRect
                    self?.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                }
            }
        }
    }
    
    private func zoomIn(toLocaction locaction: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: locaction.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(coordinateRegion, animated: true)
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

//MARK: - Location Manager delegates
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("🛑 Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            selfLocation = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        }
    }
}

// MARK: - MapView Delegate
extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let rendered = MKPolylineRenderer(overlay: overlay)
        if isBestRoute {
            isBestRoute = false
            rendered.strokeColor = UIColor.purple
            rendered.lineWidth = 5
        } else {
            rendered.strokeColor = UIColor.lightGray
            rendered.lineWidth = 5
        }
        return rendered
    }
    
}


// MARK: Actions
extension MainViewController {
    @IBAction func openStartLocation(_ sender: UIButton) {
        if let startAnnonation = startAnnonation {
             mapView.removeAnnotation(startAnnonation)
        }
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        locationSelected = .start
        
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @IBAction func openDestinationLocation(_ sender: UIButton) {
        if let destinationAnnotation = destinationAnnotation {
            mapView.removeAnnotation(destinationAnnotation)
        }
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        locationSelected = .destination
        
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @IBAction func showDirection(_ sender: UIButton) {
        self.drawPath()
    }
}

// MARK: - GMS Auto Complete Delegate, for autocomplete search location
extension MainViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("‼️ Error \(error)❌")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let address = place.formattedAddress ?? ""
        
        let longitude = place.coordinate.longitude
        let latitude = place.coordinate.latitude
        
        zoomIn(toLocaction: CLLocation(latitude: latitude, longitude: longitude))
        
        if locationSelected == .start {
            if let start = startAnnonation { mapView.removeAnnotation(start) }
            locationStart = CLLocation()
            createMarker(forLocation: .start, titleMarker: "Start Location", subTitle: address, latitude: latitude, longitude: longitude)
            locationStart = CLLocation(latitude: latitude, longitude: longitude)
        } else {
            if let destination = destinationAnnotation { mapView.removeAnnotation(destination) }
            locationDestination = CLLocation()
            createMarker(forLocation: .destination, titleMarker: "Destination Location", subTitle: address, latitude: latitude, longitude: longitude)
            locationDestination = CLLocation(latitude: latitude, longitude: longitude)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}
