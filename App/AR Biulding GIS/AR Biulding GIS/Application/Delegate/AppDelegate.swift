//
//  AppDelegate.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 02.10.2020.
//

import UIKit
import NMAKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


let credentials = (
              appId: "7T8UgnMEkQDNCeJH182A",
              appCode: "wfyqs2ZxyVaiTgdkqDnIcQ",
              licenseKey: "A4EShN5RGEb8+orRJRk6bg3V2fO97YNbJ7B9BN/DEiyYsEDPOUbs83NVtkwWzSQsy/nuiBCjl6S3kFrbHgis6nwsdTlk3HjQHFr+VeVbFa6g580Oxga/CitPWXMyeFkyrw3adKQvVQfuoMMYCeBX0Cz96BPxrblOVEhf5pLBnqpNjeGfB+bafaByRIM18IlrzYL9+pLmLrf/WnAZ/N/shh2zht2jUFnNw7QM6JsnGH2ugIsn6G1SG7Cwi5vOL2o+NaXfIl0SnSBFAhXuaoScnzZyOoxuD3PhddnHGROMkqD4AUbVddYOb4DFP+ggBtsCtyWTp/FQW1WYiXQmLJEzOnie9fivjl8C2Gi2aaGizeZfc98ZkTKhEEqcVVJ6PRlwpzvKsVqKcTFLpmt6LnJI1BEVlMW1dYFuu26g3GbgEGhv/liVEBBdZ8n8gxpL7jw4GI01WS00rUD42OxwI4AOpnHv1IbUTCbTuPe5RKtA2Bjr59ybRijSbYn4tmSwDrqvGoNVzsKswKshlENyTBQjCugKv7vsfN9Mkx7NzRfhfLyGQgGlybW12JVrRr2x1sTAfaRonAu5AAZ1ClJUvDH0Rf72i2Z/zemPnrQtzPpQdLYutFX2q/7CB0bvPApjqYMhqIy3s2HRUFMeq7CkZTrR2rV5qFv7jKYc3NEjXauDRC4="
          )
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NMAApplicationContext.setAppId(credentials.appId,
                                       appCode: credentials.appCode,
                                       licenseKey: credentials.licenseKey)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

