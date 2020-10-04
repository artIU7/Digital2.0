//
//  helperGeometry.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
import NMAKit
extension MapSceneViewController {
    func createPolygon(geoCord : NMAGeoCoordinates,w : Float, h : Float,c : UIColor) {
        
        //create a NMAGeoBoundingBox with center gec coordinates, width and hegiht in degrees.
        geoBox = NMAGeoBoundingBox(center: geoCord,
                                    width: w,
                                   height: h)
        //create a NMAMapPolygon with bounding box's vertices.
        geoPolygon = geoBox.map{ NMAMapPolygon(vertices: [$0.topLeft,
                                                          $0.bottomLeft,
                                                          $0.bottomRight,
                                                          $0.topRight]) }

        //set fill color to be gray
        geoPolygon?.fillColor = c//UIColor.gray
        //set border line width in pixels
        geoPolygon?.lineWidth = 2
        //set line color to be red
        geoPolygon?.lineColor = UIColor.red
        //add this NMAMapPolygon to map view
        _ = geoPolygon.map{viewMap.add(mapObject: $0)}
    }

}
extension MapSceneViewController {
    func mapView(_ mapView: NMAMapView, didReceiveDoubleTapAt location: CGPoint) {
            var getCoordinate = mapView.geoCoordinates(from: location)
        let lat = String(getCoordinate!.latitude)
        let lon = String(getCoordinate!.longitude)
        urlMaphere =  "https://image.maps.ls.hereapi.com/mia/1.6/mapview?apiKey=JdbJa6yZk5MljMzUe9bUO8X8FpHsF02J7UdmHY6hoKs&i&c=\(lat),\(lon)&h=500&w=500&r=500"
            getImage(url: urlMaphere)
            let pinColor = #colorLiteral(red: 0.205870576, green: 0.9056350442, blue: 0.9942695114, alpha: 0.8146671661)
            let cmpColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            var array = [NMAGeoCoordinates]()
            var rows = [[NMAGeoCoordinates]]()
            
            for i in [0,90,180,270] {
                let tmp_point = firstGeoTask(getCoordinate!, 200, Double(i))//firstGeoTask(getCoordinate,i)
                createCircle(geoCoord: tmp_point, color: pinColor, rad: 2, name: "Mesh")
                array.append(NMAGeoCoordinates(latitude: tmp_point.latitude, longitude: tmp_point.longitude, altitude: 2))
            }
        let last = array.first!
        array.append(last)
        for i in 0...array.count - 2  {
            var newArray = seperateRoute(startPoint: array[i], endPoint: array[i + 1], seg: 50)
            for l in newArray {
                createCircle(geoCoord: l, color: cmpColor, rad: 2, name: "Mesh")
            }
            rows.append(newArray)
            createPolyline(CTR: newArray, UIColor.white, 2, isShow: true)
        }
        for i in 0...rows.count - 2 {
            let clm = rows[i]
            let hlm = rows[i+1]
            for j in 0...clm.count - 2 {
                var newArray = seperateRoute(startPoint: clm[j], endPoint: hlm[j + 1], seg: 50)
                for l in newArray {
                    createCircle(geoCoord: l, color: cmpColor, rad: 2, name: "Mesh")
                }
                createPolyline(CTR: newArray, UIColor.white, 2, isShow: true)

            }
        }
            createCircle(geoCoord: getCoordinate!, color: pinColor, rad: 2, name: "Mesh")
            //createPolygon(geoCord: getCoordinate!, w: 1, h: 1,c: pinColor)
    }
    func mapView(_ mapView: NMAMapView, didSelect objects: [NMAViewObject]) {
        print("object: \(objects)")
        }
    
    public func createCircle(geoCoord : NMAGeoCoordinates, color : UIColor,rad : Int,name : String) {
        //create NMAMapCircle located at geo coordiate and with radium in meters
        mapCircle = NMAMapCircle(geoCoord, radius: Double(rad))
        mapCircle?.fillColor = color
        mapCircle?.lineWidth = 12;
        mapCircle?.lineColor = color
        _ = mapCircle.map{ viewMap.add(mapObject: $0)
        }
    }
    public func createPolyline(CTR : [NMAGeoCoordinates],_ color : UIColor , _ width : Int, isShow : Bool) -> NMAMapPolyline {
        geoBox1 = NMAGeoBoundingBox(coordinates: CTR)
        geoPolyline = geoBox1.map{ _ in NMAMapPolyline(vertices: CTR) }
        geoPolyline?.lineWidth = UInt(width);
        geoPolyline?.lineColor = color//UIColor(displayP3Red: 0.6, green: 0.8, blue: 1, alpha: 0.6)
        if isShow == true {
        _ = geoPolyline.map { viewMap?.add(mapObject: $0) }
        }
        return geoPolyline!
    }
    public struct objectPoint {
        var polyGon : NMAMapPolygon?
        var polyBox : NMAGeoBoundingBox?
    }
    public func drawPolygonWithPoints(centrBox : [NMAGeoCoordinates],fillClr : UIColor,fillLnr : UIColor) ->
        NMAMapPolygon? {
        var object = objectPoint()
        var geoBoxPolygon : NMAGeoBoundingBox?
        var boxPoly : NMAMapPolygon?
        boxPoly = NMAMapPolygon.init(vertices: centrBox)
        object.polyGon = boxPoly
        boxPoly?.fillColor = fillClr//#colorLiteral(red: 0.0202548003, green: 0.8078431373, blue: 0, alpha: 0.6264029489)
        boxPoly?.lineWidth = 3
        boxPoly?.lineColor = fillLnr//#colorLiteral(red: 0.1882352941, green: 0.4078431373, blue: 0.4392156863, alpha: 0.5)
        boxPoly?.isVisible = true
        return object.polyGon
    }
}
 
