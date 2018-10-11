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
    
    // Add delegate protocol as attribute
    var delegate: WeatherAPIDelegate?
    
    
    func fetchForecast(_ url: String) {
        // Implement checking cache for existing data, to ensure minimal network traffic
        let config = URLSessionConfiguration.default

        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            WeatherAPI.sharedInstance.forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data!)
            
            DispatchQueue.main.async {
                
                for i in 0..<WeatherAPI.sharedInstance.forecastResponse!.list.count {
                    WeatherAPI.sharedInstance.forecastResponse?.list[i].imageData = URL(string: WeatherAPI.getForecastIconBaseURL() + WeatherAPI.sharedInstance.forecastResponse!.list[i].weather[0].icon + ".png")
                }
                
                DispatchQueue.main.async {
                    self.delegate?.didFinishDownloading(self)
                }
            }
        }
    }
    
    static func convertUnixToDate(_ val: Double) -> String {
        let date = Date(timeIntervalSince1970: val)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        return dateFormatter.string(from: date)
    }
    
    static func getCurrentForecastURL() -> String {
        return "https://api.openweathermap.org//data/2.5/find?q=Tampere&units=metric&APPID=2efdd29109157be45097ce4403c69d23"
    }
    
    static func getFiveDayForecastURL() -> String {
        return ""
    }
    
    static func getForecastIconBaseURL() -> String {
        return "https://openweathermap.org/img/w/"
    }
}
