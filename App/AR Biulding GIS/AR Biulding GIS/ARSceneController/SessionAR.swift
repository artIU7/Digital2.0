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
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        //     node.enumerateChildNodes { child, _ in
        //         child.removeFromParentNode()
         //
        //     let planeNode = SCNNode.createPlaneNode(planeAnchor: planeAnchor)
        //     node.addChildNode(planeNode)
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
