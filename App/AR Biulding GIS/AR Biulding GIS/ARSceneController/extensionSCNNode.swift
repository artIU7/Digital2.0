//
//  extensionSCNNode.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
import ARKit

extension SCNVector3 {
    func length() -> Float {
        return sqrtf(x * x + y * y + z * z)
    }
    static func + (_ a : SCNVector3,_ b : SCNVector3) -> SCNVector3 {
        let c = SCNVector3(a.x+b.x, a.y+b.y, a.z + b.z)
        return c
    }
}
extension SCNGeometry {
    class func line(from vector1: SCNVector3, to vector2: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        return SCNGeometry(sources: [source], elements: [element])
    }
}
extension SCNNode {
   public func nodeAnimation(_ nodeAnimation : SCNNode) {
        let animationGroup = CAAnimationGroup.init()
        animationGroup.duration = 1.0
        animationGroup.repeatCount = .infinity
    
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(value: 1.0)
        opacityAnimation.toValue = NSNumber(value: 0.5)
    
        let spin = CABasicAnimation.init(keyPath: "rotation")
        spin.fromValue = NSValue(scnVector4: SCNVector4(x: 0, y: 25, z: 0, w: 0))
        spin.toValue = NSValue(scnVector4: SCNVector4(x:0, y: 25, z: 0, w: Float(CGFloat(2 * M_PI))))
        spin.duration = 3
        spin.repeatCount = .infinity
        animationGroup.animations = [opacityAnimation,spin]
        nodeAnimation.addAnimation(animationGroup, forKey: "animations")
    }
}
