//
//  gesturedelegate.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
//import heresdk
import UIKit

/*
extension MapViewController : TapDelegate,DoubleTapDelegate,LongPressDelegate,PanDelegate {
    func onTap(origin: Point2D) {
        //
        let geoCoordinates = mapView.viewToGeoCoordinates(viewCoordinates: origin)!
    }
    // MARK :: DoubleDelegate
    // realizing conform methods protocol TapDelegate
    func onDoubleTap(origin: Point2D) {
        //
        let geoCoordinates = mapView.viewToGeoCoordinates(viewCoordinates: origin)!
        arrayPolyLine?.append(geoCoordinates)
        
        modelPolyLine?.append(GeoCoordinates(latitude: geoCoordinates.latitude, longitude: geoCoordinates.longitude, altitude: 20))
        
        mapView.mapScene.addMapPolygon(createMapCircle(positon: geoCoordinates))
    }
    // MARK :: longPressDelegate
    // realizing conform methods protocol TapDelegate
    func onLongPress(state: GestureState, origin: Point2D) {
        //
        switch state {
            
        case .end:
            var position = mapView.viewToGeoCoordinates(viewCoordinates: origin)!
            position = GeoCoordinates(latitude: position.latitude, longitude: position.longitude, altitude: 0.0)
            addAction(position as Any)
        case .update: break
        //
        case .begin:
            stopDraw("Draw" as Any)
        //
            
        case .cancel: break
        //
        @unknown default: break
            //
        }
    }
    // MARK :: TapDelegate
    // realizing conform methods protocol TapDelegate
    func onPan(state: GestureState, origin: Point2D, translation: Point2D, velocity: Double) {
        //
        
    }
    // Sub method actionUI
    func addAction(_ object : Any) {
        // MARK add UI Alert test delegate
        let alert = UIAlertController(title: "Location From Tap Delegate", message: "\(String(describing: object))", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Отмена", style: .default) {
            (_) -> Void in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    // Sub method actionUI
    func stopDraw(_ object : Any) {
        // MARK add UI Alert test delegate
        let alert = UIAlertController(title: "Stop Add Poly", message: "\(String(describing: object))", preferredStyle: .alert)
        let addPoint = UIAlertAction(title: "Добавить", style: .default) { [self]   (_) -> Void in
            mapView.gestures.disableDefaultAction(forGesture: .doubleTap)
            mapView.gestures.doubleTapDelegate = self
        }
        let okAction = UIAlertAction(title: "Завершить", style: .default) { [self]
            (_) -> Void in
            let firstelement = arrayPolyLine?.first
            arrayPolyLine?.append(firstelement!)
         //   mapView.mapScene.addMapPolyline(createMapPolyline(arrayPolyline: self.arrayPolyLine!)!)
            //
            let secondelement = modelPolyLine?.first
            modelPolyLine?.append(secondelement!)
            mapView.mapScene.addMapPolyline(createMapPolyline(arrayPolyline: self.modelPolyLine!)!)
            
            mapView.mapScene.addMapPolygon(createMapPolygon(polyArray: self.modelPolyLine!))
            
            //
           // for i in 0...arrayPolyLine?.count - 1 {
           //     /
           // }
            //
            mapView.gestures.enableDefaultAction(forGesture: .doubleTap)
            mapView.gestures.doubleTapDelegate = nil
        }
        alert.addAction(okAction)
        alert.addAction(addPoint)
        self.present(alert, animated: true, completion: nil)
    }
    // get marker info
    
}
*/
