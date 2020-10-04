//
//  helperPositionIndicator.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 02.10.2020.
//

import Foundation
//import heresdk
import UIKit
/*extension MapViewController {
    func createMapCircle(positon : GeoCoordinates) -> MapPolygon {
        let geoCircle = GeoCircle(center: positon,
                                  radiusInMeters: 2.0)

        let geoPolygon = GeoPolygon(geoCircle: geoCircle)
        let fillColor = Color(red: 0x00, green: 0x90, blue: 0x8A, alpha: 0xA0)
        let mapPolygon = MapPolygon(geometry: geoPolygon, color: fillColor)
        let metadata = Metadata()
            metadata.setString(key: "key_poly", value: "Indicator")
            mapPolygon.metadata = metadata
        return mapPolygon
    }
    func createMapPolygon(polyArray : [GeoCoordinates]) -> MapPolygon {
        // Note that a polygon requires a clockwise order of the coordinates.
        let coordinates = polyArray

        // We are sure that the number of vertices is greater than three, so it will not crash.
        let geoPolygon = try! GeoPolygon(vertices: coordinates)
        let color_start = #colorLiteral(red: 0.5707338674, green: 0.4626230736, blue: 0.7481227382, alpha: 1)
        let fillColor = Color(red: 0x00, green: 0x90, blue: 0x8A, alpha: 0xA0)
        let mapPolygon = MapPolygon(geometry: geoPolygon, color: color_start)

        return mapPolygon
    }
    func myLocationHere(location : GeoCoordinates) {
        // add circle
        let mapCircle = createMapCircle(positon: location)
        let mapScene = mapView.mapScene
        mapScene.addMapPolygon(mapCircle)
    }
}
*/
