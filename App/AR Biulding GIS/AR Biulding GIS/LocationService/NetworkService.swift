//
//  NetworkService.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
import UIKit

var poi = [ARObject]()
var ctr = [coordinate]()
var poa = [coordinate]()
var vLocal = [coordinate]()
struct coordinate : Codable{
    var lat : Double
    var lot : Double
}
struct ARObject : Codable {
    let id : Int
    let name : String
    let resource : String
    let position : [coordinate]
    let locate : [coordinate]
}
var googleImage : UIImage!

extension MapSceneViewController {
    //  load image api here
    func getImage(url : String) {
           var image = UIImage()
           guard let url = URL(string: url) else {return}
                  let session = URLSession.shared
                  session.dataTask(with: url) { (data,response,error) in
                      if let response = response {
                          print(response)
                      }
                      guard let data = data else {return}
                      do {
                       image = UIImage(data: data)!
                       arImage = image
                       print(image.description)
                      } catch {
                          print(error)
                      }
                  }.resume()
       }
}


extension MapSceneViewController {
    // get запрос обьектов
    func loadArea() {
        let urlString = "https://building_gis.herokuapp.com/objects"
        ctr.removeAll()
        vLocal.removeAll()
               if let url = URL(string: urlString) {
                   if let data = try? Data(contentsOf: url) {
                   //    parse(json: data)
                  do {
                                   // make sure this JSON is in the format we expect
                                   if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                                       // try to read out a string array
                                       print(json)
                                       for each in json {
                                           let obj = each["locate"] as! NSArray
                                           for p in obj  {
                                               var a = p as! [String:Any]
                                               ctr.append(coordinate.init(lat: a["lat"] as! Double, lot: a["lot"] as! Double))
                                           }
                                            let pos = each["position"] as! NSArray
                                                for p in pos  {
                                                    var a = p as! [String:Any]
                                                poa.append(coordinate.init(lat: a["lat"] as! Double, lot: a["lot"] as! Double))
                                            }
                                        let insertUser = ARObject(id: each["id"] as! Int, name: each["name"] as! String,resource: each["resource"] as! String, position : poa, locate: ctr)
                                            poi.append(insertUser)
                                            ctr.removeAll()
                                            poa.removeAll()
                                       }
                                   }
                               } catch let error as NSError {
                                   print("Failed to load: \(error.localizedDescription)")
                        }
                }
        }
    }
  // post запрос обьектов
    func post(url : String,parametrs : [String:Any]) {
        guard let url = URL(string: url) else {return}
        let parametrs = parametrs//["lon":48.3,"lat":38.5]
        var request = URLRequest(url : url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        guard let httBody = try? JSONSerialization.data(withJSONObject: parametrs, options: [.fragmentsAllowed]) else { return }
        request.httpBody = httBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data,response,error) in
            if let response = response {
                print(response)
            }
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                 print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}

