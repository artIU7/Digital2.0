//
//  sceneView.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
import UIKit
import SceneKit
import CoreLocation
import NMAKit

extension MapSceneViewController {
    
  func setupSceneView() {
        // transparent background for use as overlay
        sceneView.backgroundColor = UIColor.clear
        scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.loops = true
        sceneView.showsStatistics = false
        sceneView.isPlaying = true
        sceneRect = sceneView.bounds
        
        // camera
        cameraNode = SCNNode()
        camera = SCNCamera()
        cameraNode.camera = camera
        scene.rootNode.addChildNode(cameraNode)
        
        // lighting
        ambientLight = SCNLight()
        ambientLight.type = .ambient
        let color =   #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        ambientLight.color = color// UIColor(colorLiteralRed: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)
        
        // lighting
        omniLight = SCNLight()
        omniLight.type = .omni
        omniLightNode = SCNNode()
        omniLightNode.light = omniLight
        scene.rootNode.addChildNode(omniLightNode)
        tokens.append(addboxNode(NMAGeoCoordinates(latitude: 55.892882956952704, longitude: 37.54391640563343),id : 0))
        tokens.append(addboxNode(NMAGeoCoordinates(latitude: 55.89176982388743, longitude: 37.54422555312789),id : 1))
    }

    func addboxNode(_ geo : NMAGeoCoordinates,id : Int) -> SCNNode {
        // office node
          let box = SCNNode(geometry: SCNBox(width: 40, height: 40.0, length: 40.0, chamferRadius: 1.0))
          box.setValue(CLLocationCoordinate2DMake(geo.latitude, geo.longitude), forKey: "coordinate")
          box.geometry?.firstMaterial?.diffuse.contents = UIColor.white
          box.geometry?.firstMaterial?.specular.contents = UIColor.white
          box.setValue(false, forKey: "tapped")
          scene.rootNode.addChildNode(box)
        /*
        let box = SCNBox(width: 1.4, height: 1.4, length: 1.8, chamferRadius: 0)
        let material = SCNMaterial()
        let pointXColor = #colorLiteral(red: 0.2670599402, green: 0.7053412321, blue: 0.721303804, alpha: 0.1422838185)
        material.diffuse.contents = pointXColor //UIColor.red
        box.materials = [material]
        let boxNode = SCNNode(geometry: box)*/
        return box
    }
    func addAnimations(_ node :  SCNNode!) {
        let rotate = SCNAction.rotateBy(x: 0, y: 0, z: 3, duration: 0.5)
        let moveSequence = SCNAction.sequence([rotate])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        node.runAction(moveLoop)
    }
    // convert geographic coordinates to screen coordinates in the map view
       func coordinateToOverlayPosition(coordinate: CLLocationCoordinate2D) -> SCNVector3 {
        let p: CGPoint = viewMap.point(from: NMAGeoCoordinates(latitude: coordinate.latitude, longitude: coordinate.longitude))
           return SCNVector3Make(Float(p.x), Float(sceneRect.size.height - p.y), 0)
       }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
          // get pitch of map
          let mapPitchRads = Float(viewMap.tilt) * (Float.pi / 180.0)
          print("current tilt :\(viewMap.tilt)")
      
          let playerPoint = coordinateToOverlayPosition(coordinate: tempPositin)
         
          // update office
          for tokenPoint in tokens {
            let officePoint = coordinateToOverlayPosition(coordinate: tokenPoint.value(forKey: "coordinate") as! CLLocationCoordinate2D)
                       tokenPoint.position = SCNVector3Make(officePoint.x, officePoint.y,5)
           // self.buildingPoint.text = "\(tokenPoint.position)"
          }
        
        omniLightNode.position = SCNVector3Make(playerPoint.x, playerPoint.y + 30, 20)
          // update camera
        let metersPerPointFirst = 0.3348600676537076//viewMap.geoCenter.distance(to: viewMap.geoCenter)///metersPerPoint(atZoomLevel: Float(viewMap.zoomLevel))
        
        print("meters point\(metersPerPointFirst)")
        print("level ground from Minimum \(viewMap.maximumZoomLevel.advanced(by: viewMap.zoomLevel))")
        print("level ground from Maximum \(viewMap.minimumZoomLevel.advanced(by: viewMap.zoomLevel))")
        
        let t1 = viewMap.maximumZoomLevel.advanced(by: viewMap.zoomLevel)
        let t2 = viewMap.minimumZoomLevel.advanced(by: viewMap.zoomLevel)
        
        let f1 = viewMap.zoomLevel.distance(to: 20)//metersPerPoint(atZoomLevel: viewMap.zoomLevel)*t2
        let f2 = viewMap.metersPerPoint(atZoomLevel: viewMap.minimumZoomLevel)*t2
        let f3 = viewMap.metersPerPoint(atZoomLevel: 0).distance(to: 20)
        print("f1 : \(f1)")
        print("f2 : \(f2)")
        print("f3 : \(f3)")
        print("altitude : \(viewMap.geoCenter.altitude)")
        print("current zoom level \(viewMap.zoomLevel)")
        
        let altitudePoints = 853.7030533228752///*viewMap.geoCenter.altitude*/ viewMap.geoCenter.altitude / Float(metersPerPointFirst) as Float
          let projMat = GLKMatrix4MakeOrtho(0, Float(sceneRect.size.width),  // left, right
              0, Float(sceneRect.size.height), // bottom, top
              1, Float(altitudePoints+100))               // zNear, zFar
          cameraNode.position = SCNVector3Make(0, 0, Float(800))
          cameraNode.camera!.projectionTransform = SCNMatrix4FromGLKMatrix4(projMat)
      }
}
