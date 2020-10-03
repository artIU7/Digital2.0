//
//  LocationManager.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 02.10.2020.
//

import Foundation
import UIKit
import heresdk
import CoreLocation

extension MapViewController  {
    // MARK 1
    func initLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
    }
    // MARK 2
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            print("Warning: No last location found")
            return
        }
        tempPositin = lastLocation.coordinate
        let camera = mapView.camera
        let orientation = MapCamera.OrientationUpdate(bearing: lastLocation.course,
                                                      tilt: 0)
        camera.setDistanceToTarget(distanceInMeters: 100)
        camera.lookAt(point: GeoCoordinates(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude), orientation: orientation,  distanceInMeters: 100 * 2)
        
        myLocationHere(location: GeoCoordinates(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude))
        print(lastLocation)
    }
    // MARK 3
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    // MARK 4
    func startLocation() {
        locationManager.startUpdatingLocation()
    }
    // MARK 5
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
}
