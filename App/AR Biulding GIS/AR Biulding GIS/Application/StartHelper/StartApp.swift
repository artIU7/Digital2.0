//
//  StartApp.swift
//  AR Biulding GIS
//
//  Created by Artem Stratienko on 03.10.2020.
//

import UIKit
import NMAKit

class StartController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // В главном окне приожения выбираем загрузку карты
    @IBAction func startApp(_ sender: Any) {
        let storyboardName = "Maps"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController!.pushViewController(initialViewController!, animated: true)
    }
}
