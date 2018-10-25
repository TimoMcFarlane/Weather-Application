//
//  WeatherAPI.swift
//  Weather
//
//  Created by Timo McFarlane on 09/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import Foundation

class WeatherAPI {
    
    var forecastResponse: ForecastResponse?
    static var sharedInstance: WeatherAPI = WeatherAPI()
    static let options: [String] = ["Tampere", "Helsinki"]
    static var activeOption: String = "Tampere"
    
    // Add delegate protocol as attribute
    var delegate: WeatherAPIDelegate?
    
    func fetchForecast(_ url: String) {
        let config = URLSessionConfiguration.default

        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            WeatherAPI.sharedInstance.forecastResponse = try! JSONDecoder().decode(ForecastResponse.self, from: data!)
            DispatchQueue.main.async {
                if let res = WeatherAPI.sharedInstance.forecastResponse {
                    for i in 0..<res.list.count {
                        res.list[i].imageData = URL(string: WeatherAPI.getForecastIconBaseURL() + res.list[i].weather[0].icon + ".png")
                    }
                }
            
                DispatchQueue.main.async {
                    self.delegate?.didFinishDownloading(self)
                }
            }
        }
    }
    
    static func setActiveOption(option: String) -> Void {
        self.activeOption = option
    }
    
    static func getActiveOption() -> String {
        return self.activeOption
    }
    
    static func getWeatherOptions() -> [String] {
        return self.options
    }
    
    static func getCurrentForecastURL() -> String {
        return "https://api.openweathermap.org//data/2.5/find?q=" + self.activeOption + "&units=metric&APPID=2efdd29109157be45097ce4403c69d23"
    }
    
    static func getFiveDayForecastURL() -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?q=" + self.activeOption + ",fi&units=metric&APPID=2efdd29109157be45097ce4403c69d23"
    }
    
    static func getForecastIconBaseURL() -> String {
        return "https://openweathermap.org/img/w/"
    }
}
