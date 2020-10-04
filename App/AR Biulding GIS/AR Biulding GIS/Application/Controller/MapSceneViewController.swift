//
//  MapSceneViewController.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import UIKit
import NMAKit
import SceneKit
var tokens = [SCNNode]()
var urlMaphere : String!

var geoPolygon : NMAMapPolygon?
var geoBox : NMAGeoBoundingBox?
var geoBox1 : NMAGeoBoundingBox?
var geoPolyline : NMAMapPolyline?
var mapCircle : NMAMapCircle?

class MapSceneViewController: UIViewController {

    @IBOutlet var viewMap: NMAMapView!
    @IBOutlet weak var sceneView: SCNView!
    
    @IBOutlet weak var buildingPoint: UILabel!
    //
    // SceneKit scene
          var scene: SCNScene!
          var cameraNode: SCNNode!
          var camera: SCNCamera!
          var playerNode: SCNNode!
          var officeNode: SCNNode!
        
          var ambientLightNode: SCNNode!
          var ambientLight: SCNLight!
          var omniLightNode: SCNNode!
          var omniLight: SCNLight!
          var sceneRect: CGRect!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
      
        self.viewMap.mapScheme = NMAMapSchemeNormalNight
        self.viewMap.positionIndicator.isVisible = false

        super.viewDidLoad()
        self.initLocationManager()
        self.startLocation()
        self.setupSceneView()
        self.viewMap.delegate = self
        self.viewMap.gestureDelegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapSceneViewController : NMAMapGestureDelegate,NMAMapViewDelegate {}
extension MapSceneViewController : CLLocationManagerDelegate {}
extension MapSceneViewController : SCNSceneRendererDelegate,SCNPhysicsContactDelegate {}
