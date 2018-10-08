//
//  Forecast.swift
//  Weather
//
//  Created by Timo McFarlane on 08/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import Foundation

class Forecast: NSObject, Codable {
    var weather: Weather
    var main: Main
    var dt: Int = 0
    var name: String = ""
    var iconUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        //Encoding/decoding will only include the properties defined in this enum, rest will be ignored
        case weather
        case name
        case main
    }
}

struct Weather: Codable {
    var main: String = ""
    var icon: String = ""
}

struct Main: Codable {
    var temp: Double = 0.0
}
