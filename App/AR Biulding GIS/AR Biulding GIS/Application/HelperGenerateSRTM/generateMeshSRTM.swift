//
//  generateMeshSRTM.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
import NMAKit


extension MapSceneViewController {
    func seperateRoute(startPoint : NMAGeoCoordinates,endPoint : NMAGeoCoordinates,seg : Int) -> [NMAGeoCoordinates]{
        var newAR = [NMAGeoCoordinates]()
        var distance = distanceGeo(pointA: startPoint, pointB: endPoint)
           distance = Double(round(1000*distance)/1000)
        var countSegment = distance/Double(seg)
        newAR.append(startPoint)
        let deltaLat = (endPoint.latitude - startPoint.latitude)/countSegment
        let deltaLot = (endPoint.longitude - startPoint.longitude)/countSegment
        if Int(countSegment) > 1 {
            for i in 0...Int(countSegment) - 1 {
                     var j = 1
                     var newPoint = NMAGeoCoordinates(latitude: deltaLat*Double(i + 1)+startPoint.latitude, longitude: deltaLot*Double(i + 1)+startPoint.longitude)
                         //coordinate(lat: deltaLat*Double(i)+startPoint.lat, lon: deltaLot*Double(i)+startPoint.lon)
                     newAR.append(newPoint)
                 }
        } else {
            newAR.append(startPoint)
         //   newAR.append(endPoint)
        }
        return newAR
    }
}

extension MapSceneViewController {
    
   public func distanceGeo(pointA : NMAGeoCoordinates,pointB : NMAGeoCoordinates) -> Double {
       let toRad = Double.pi/180
       let radial = acos(sin(pointA.latitude*toRad)*sin(pointB.latitude*toRad) + cos(pointA.latitude*toRad)*cos(pointB.latitude*toRad)*cos((pointA.longitude - pointB.longitude)*toRad))
       let R = 6378.137//6371.11
       let D = (radial*R)*1000
       return D
   }
    public func findDirection(_ startPoint : NMAGeoCoordinates, _ aizmutDirection : Double) -> NMAGeoCoordinates {
        let deltaLat = cos(aizmutDirection)
        let deltaLon = sin(aizmutDirection)
        let direction = [deltaLat,deltaLon]
        let fromLat = startPoint.latitude
        let fromLon = startPoint.longitude
        let endPoint = NMAGeoCoordinates(latitude: fromLat + deltaLat, longitude: fromLon + deltaLon,altitude : 20)
        return endPoint
    }
    public func firstGeoTask(_ firstPoint : NMAGeoCoordinates, _ deltaMetr : Double, _ directionRotate : Double) -> NMAGeoCoordinates {
        let toRad = Double.pi/180
        let Re = 6371000
        let deltaX = deltaMetr * cos(directionRotate*toRad)/(Double(Re)*toRad)
        let deltaY = deltaMetr * sin(directionRotate*toRad)/cos(firstPoint.latitude*toRad)/(Double(Re)*toRad)
        let newX = firstPoint.latitude + deltaX
        let newY = firstPoint.longitude + deltaY
        let secondPoint = NMAGeoCoordinates(latitude: newX, longitude: newY)
        return secondPoint
    }
}
