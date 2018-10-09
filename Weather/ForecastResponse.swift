//
//  Forecast.swift
//  Weather
//
//  Created by Timo McFarlane on 08/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import Foundation

class ForecastResponse: NSObject, Codable {
    
    var cod: String = ""
    var list: [Forecast]
    
    enum Keys: String, CodingKey {
        case cod
        case list
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.cod = try container.decode(String.self, forKey: .cod)
        self.list = try container.decode([Forecast].self, forKey: .list)
    }
}

struct Forecast: Codable {
    var name: String = ""
    var main: Main
    var coord: Coordinates
    var weather: Weather
}

struct Coordinates: Codable {
    var lat: Double = 0.0
    var lon: Double = 0.0
}

struct Weather: Codable {
    var main: String = ""
    var icon: String = "https://openweathermap.org/img/w/"
}

struct Main: Codable {
    var temp: Double = 0.0
}

