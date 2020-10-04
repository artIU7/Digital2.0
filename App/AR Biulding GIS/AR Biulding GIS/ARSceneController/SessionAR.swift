//
//  SessionAR.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
import ARKit

// MARK section render(:)
extension ARSceneController {
    
 
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // 3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z) 
        //guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        //     node.enumerateChildNodes { child, _ in
        //         child.removeFromParentNode()
         //
        //     let planeNode = SCNNode.createPlaneNode(planeAnchor: planeAnchor)
        //     node.addChildNode(planeNode)
    }
    // rendering
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        let color =   #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.6974261558)
        plane.materials.first?.diffuse.contents = color//arImage//color //UIColor.transparentLightBlue
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        node.addChildNode(planeNode)
        /* guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
             let planeNode = SCNNode.createPlaneNode(planeAnchor: planeAnchor)
             node.addChildNode(planeNode) */
        //node.addChildNode(sphere(pos: SCNVector3(<#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##z: CGFloat##CGFloat#>)))
    }
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
       
    }
}
extension SCNNode {
    
    static func createPlaneNode(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let scenePlaneGeometry = ARSCNPlaneGeometry(device: MTLCreateSystemDefaultDevice()!)
        scenePlaneGeometry?.update(from: planeAnchor.geometry)
        let planeNode = SCNNode(geometry: scenePlaneGeometry)
        switch planeAnchor.alignment {
        case .horizontal:
            planeNode.geometry?.firstMaterial?.diffuse.contents = arImage//      material.diffuse.contents = image
        case .vertical:
            planeNode.geometry?.firstMaterial?.colorBufferWriteMask = .alpha
            
        }
        return planeNode
    }
    
}
