//
//  NetworkService.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import Foundation
import UIKit

extension MapViewController {
    // выгрузка картинок
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

