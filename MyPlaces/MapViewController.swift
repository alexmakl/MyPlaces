//
//  MapViewController.swift
//  MyPlaces
//
//  Created by Alexander on 25/04/2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var place: Place!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaceMark()
    }
    
    @IBAction func closeVC() {
        dismiss(animated: true)
    }
    
    private func setupPlaceMark() {
        
        guard let location = place.location else { return }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks,error) in
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            
            let annotarion = MKPointAnnotation()
            annotarion.title = self.place.name
            annotarion.subtitle = self.place.type
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotarion.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotarion], animated: true)
            self.mapView.selectAnnotation(annotarion, animated: true)
        }
    }
}
