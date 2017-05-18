//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Milos Hovjecki on 5/13/17.
//  Copyright © 2017 hanacode.swd. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    
    func configureCell (forecast: Forecast) {
        
        lowTempLbl.text = "\(forecast.lowTemp)"
        highTempLbl.text = "\(forecast.hightemp)"
        weatherTypeLbl.text = forecast.weatherType
        dayLbl.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }

}
