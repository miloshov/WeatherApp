//
//  LaunchScreenVC.swift
//  WeatherApp
//
//  Created by Milos Hovjecki on 10/19/17.
//  Copyright © 2017 hanacode.swd. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var gifImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gifImage.loadGif(name: "LaunchingTheme-750x1134@1x")
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ShowMainViewController), userInfo: nil, repeats: false)

    }
        
    @objc func ShowMainViewController () {
     
        performSegue(withIdentifier: "toWeatherVC", sender: self)
    }
    
}
