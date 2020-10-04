//
//  ViewController.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 02.10.2020.
//

import UIKit
//import heresdk
import CoreLocation

var tempPositin : CLLocationCoordinate2D!
var manualPosition : CLLocationCoordinate2D!
//var urlMaphere : String!

/*

class MapViewController: UIViewController {
  
    //
    @IBOutlet var mapView: MapView!
    //
    let locationManager = CLLocationManager()
    //
    var arrayPolyLine : [GeoCoordinates]? = []
    var modelPolyLine : [GeoCoordinates]? = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlMaphere = "https://image.maps.ls.hereapi.com/mia/1.6/mapview?apiKey=JdbJa6yZk5MljMzUe9bUO8X8FpHsF02J7UdmHY6hoKs&i&c=43.111310,131.918209&h=500&w=500&r=500"
        manualPosition = CLLocationCoordinate2D(latitude: 43.111310, longitude: 131.918209)
        // Do any additional setup after loading the view.
        mapView.mapScene.loadScene(mapScheme: MapScheme.greyDay, completion: onLoadScene)
        initLocationManager()
        mapView.gestures.longPressDelegate = self
        getImage(url: urlMaphere)
        //startLocation()
    }
    // Load scene mapView
    private func onLoadScene(mapError: MapError?) {
        guard mapError == nil else {
            print("Error: Map scene not loaded, \(String(describing: mapError))")
            return
        }
        mapView.mapScene.setLayerState(layerName: MapScene.Layers.trafficFlow,
                                       newState: MapScene.LayerState.visible)
        mapView.mapScene.setLayerState(layerName:MapScene.Layers.trafficIncidents,
                                       newState: MapScene.LayerState.visible)
        // Configure the map.
     //   guard tempPositin != nil else {
     //       return
     //   }
        let camera = mapView.camera
        camera.setDistanceToTarget(distanceInMeters: 100)
        camera.lookAt(point: GeoCoordinates(latitude: manualPosition.latitude, longitude: manualPosition.longitude), distanceInMeters: 100*2)
    }
}

extension MapViewController : CLLocationManagerDelegate {}
*/
