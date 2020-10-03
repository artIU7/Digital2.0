//
//  ARController.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import CoreLocation

var arImage = UIImage()
var startingLocation: CLLocation!
var location: CLLocation!
var locations: [CLLocation] = []
var areaRing: [CLLocation] = []
var allowNode : SCNNode!
var buildNode : SCNNode!
// Класс ARScene
class ARSceneController: UIViewController, ARSCNViewDelegate  {
 
    private var anchors: [ARAnchor] = []
        
    @IBOutlet var sceneView: ARSCNView!
    
    
    private let configuration = ARWorldTrackingConfiguration()
       
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sceneView.delegate = self
        //sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
        runSession()
        initTap()
    }
    // Init Сессия
    func runSession() {
        configuration.worldAlignment = .camera
        configuration.planeDetection = [.horizontal,.vertical]

        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin,ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showCameras,ARSCNDebugOptions.showBoundingBoxes]
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
       }
}
// методы session
extension ARSceneController {
    
    // MARK: - ARSCNViewDelegate
    
    func session(_ session: ARSession, didFailWithError error: Error) {
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            print("ready")
        case .notAvailable:
            print("wait")
        case .limited(let reason):
            print("limited tracking state: \(reason)")
        }
    }
    // rendering
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
             let planeNode = SCNNode.createPlaneNode(planeAnchor: planeAnchor)
             node.addChildNode(planeNode)
        //node.addChildNode(sphere(pos: SCNVector3(<#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##z: CGFloat##CGFloat#>)))
    }
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
       
    }
}
// взаимодейтсвие с AR через tap по обьект
extension ARSceneController {
    func buildingPrimitive(_ vec : SCNVector3) {
        let box = SCNBox(width: 1.4, height: 1.4, length: 1.8, chamferRadius: 0)
        let material = SCNMaterial()
        let pointXColor = #colorLiteral(red: 0.2670599402, green: 0.7053412321, blue: 0.721303804, alpha: 0.1422838185)
        material.diffuse.contents = pointXColor //UIColor.red
        box.materials = [material]
        let boxNode = SCNNode(geometry: box)
        boxNode.position = vec //SCNVector3(0,0,-0.5)
        //sceneView.scene.rootNode.addChildNode(boxNode)
        self.sceneView.scene.rootNode.addChildNode(boxNode)
    }
    func sphere (pos : SCNVector3) -> SCNNode {
        let geometry = SCNSphere(radius: 0.3)
        geometry.firstMaterial?.diffuse.contents = UIColor.red
            let sphereNode = SCNNode(geometry: geometry)
        sphereNode.position = SCNVector3(pos.x,pos.y + 0.2,pos.z)
return sphereNode        }
    func initTap() {
         let tapRec = UITapGestureRecognizer(target: self,
                                             action: #selector(ARSceneController.handleTap(rec:)))
         tapRec.numberOfTouchesRequired = 1
         self.sceneView.addGestureRecognizer(tapRec)
    }
     @objc func handleTap(rec: UITapGestureRecognizer){
        if rec.state == .ended {
            let location: CGPoint = rec.location(in: sceneView)
            let hits = self.sceneView.hitTest(location, options: nil)
            if let tappednode = hits.first?.node {
                print("tappennode :")
               // planeNode.eulerAngles.x = -.pi / 2
                buildingPrimitive(tappednode.position)
                sphere(pos: tappednode.position)
            }
        }
    }
    // func computed offset for new coordinate
           func offsetComplete(_ pointStart : CLLocationCoordinate2D, _ pointEnd : CLLocationCoordinate2D) -> [Double] {
               let toRadian = Double.pi/180
               let toDegress = 180/Double.pi
               var deltaX = Double()
               var deltaZ = Double()
               var offset = [Double]()
               let defLat = (2*Double.pi * 6378.137)/360
               let defLot = (2*Double.pi*6378.137*cos(pointStart.latitude*toRadian))/360//*toDegress
                   if pointStart != nil {
                       if pointEnd != nil {
                           deltaX = (pointEnd.longitude - pointStart.longitude)*defLot*1000//*toDegress
                           deltaZ = (pointEnd.latitude - pointStart.latitude)*defLat*1000//*toDegress
                           var lon = (pointStart.longitude*defLot/*1000*/ + deltaX)/defLot/*1000*///*toDegress
                           var lat = (pointStart.latitude*defLat + deltaZ)/defLat//*toDegress
                           print("\(pointEnd.longitude - pointStart.longitude)")
                           print("\(pointEnd.latitude - pointStart.latitude)")
             }
        }
               offset.append(deltaX)
               offset.append(deltaZ)
           return offset
       }
}
