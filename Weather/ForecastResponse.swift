//
//  Forecast.swift
//  Weather
//
//  Created by Timo McFarlane on 08/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import UIKit

class ForecastResponse: NSObject, Codable {
    
    var list: [Forecast]
    
    enum Keys: String, CodingKey {
        case list
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.list = try container.decode([Forecast].self, forKey: .list)
    }
}

struct Forecast: Codable {
    var name: String?
    var main: Main
    var dt: Int = 0
    var weather: [Weather]
    var imageData: URL?
    var dt_txt: String?
}

struct Weather: Codable {
    var main: String = ""
    var icon: String = ""
}

struct Main: Codable {
    var temp: Double = 0.0
}

