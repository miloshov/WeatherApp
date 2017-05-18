//
//  Location.swift
//  WeatherApp
//
//  Created by Milos Hovjecki on 5/13/17.
//  Copyright © 2017 hanacode.swd. All rights reserved.
//

import CoreLocation



class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
