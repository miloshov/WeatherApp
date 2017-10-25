//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Milos Hovjecki on 4/29/17.
//  Copyright © 2017 hanacode.swd. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate  {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todayLbl: UILabel!

    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayLbl.isHidden = true

        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus () {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location!
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                
                self.downloadForecastData {
                    
                    self.updateMainUi()
                }
                
            }

            
        } else {
            
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
            
        }
        
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Downloading forecast weather data for TableView
        
        // let forecastURL = URL(string: FORECAST_URL)!
        
        Alamofire.request(FORECAST_URL).responseJSON { response in
            
         let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        
                        let forecast = Forecast(weatherDict: obj)
                        
                        self.forecasts.append(forecast)
                        
                        // print(obj)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
                self.todayLbl.isHidden = false

                
            }
            
            completed()
        }
    }

    
    // TableView Setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Number of sections or colums
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count // Number of rows in section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forcast = forecasts[indexPath.row]
            
            cell.configureCell(forecast: forcast)
            
            return cell
            
        } else {
            
            return WeatherCell()
            
        }
        
    }
    
    func updateMainUi() {
        
        dateLbl.text = currentWeather.date
        temperatureLbl.text = String(format: "%.0f°|", currentWeather.currentTemp)
        weatherLbl.text = currentWeather.weatherType
        locationLbl.text = currentWeather.cityName
        weatherImage.image = UIImage(named: currentWeather.weatherType)
        
        
    }
    
}

