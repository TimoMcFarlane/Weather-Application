//
//  FirstViewController.swift
//  Weather
//
//  Created by Timo McFarlane on 04/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, WeatherAPIDelegate {
    var forecast: ForecastResponse?
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var weatherTemp: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.async {
            WeatherAPI.sharedInstance.fetchForecast(WeatherAPI.getCurrentForecastURL())
        }
    }
    
    
    func didFinishDownloading(_ sender: WeatherAPI) {
        DispatchQueue.main.async(execute: {() in
            if let fetchedForecast = WeatherAPI.sharedInstance.forecastResponse {
                self.forecast = fetchedForecast
            }
            
            if let url = WeatherAPI.sharedInstance.forecastResponse?.list[0].imageData {
                if let data = NSData(contentsOf: url) {
                    self.weatherIcon.contentMode = UIView.ContentMode.scaleAspectFit
                    self.weatherIcon.image = UIImage(data: data as Data)
                }
            }
            self.locationLabel.text! = (self.forecast?.list[0].name)!
            self.weatherTemp.text! = String(format: "%.1f", Double(round(1000*(self.forecast?.list[0].main.temp)!))/1000) + "°C"
            self.activityIndicatorView.stopAnimating()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        WeatherAPI.sharedInstance.delegate = self
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        
    }
    

}

