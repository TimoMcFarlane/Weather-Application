//
//  SecondViewController.swift
//  Weather
//
//  Created by Timo McFarlane on 04/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController, WeatherAPIDelegate {

    var forecast: ForecastResponse?
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.separatorStyle = .none
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.async {
            WeatherAPI.sharedInstance.fetchForecast(WeatherAPI.getFiveDayForecastURL())
        }
    }
    
    
    func didFinishDownloading(_ sender: WeatherAPI) {
        DispatchQueue.main.async(execute: {() in
            if let fetchedForecast = WeatherAPI.sharedInstance.forecastResponse {
                self.forecast = fetchedForecast
            }
            
            self.activityIndicatorView.stopAnimating()
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        WeatherAPI.sharedInstance.delegate = self
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        tableView.backgroundView = activityIndicatorView
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fc = self.forecast {
            return fc.list.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return WeatherAPI.getActiveOption()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondIdentifier") as! CustomTableViewCell
        
        cell.weatherTemp.text! = String(format: "%.1f", Double(round(1000*(self.forecast?.list[indexPath.row].main.temp)!))/1000) + "°C"
        cell.weatherTemp.textAlignment = .right
        
        if(self.forecast != nil) {
            cell.weatherDate.text! = (self.forecast?.list[indexPath.row].dt_txt!)!
            cell.weatherType.text! = ((self.forecast?.list[indexPath.row].weather[0].main)!)
        }
        

        if let url = WeatherAPI.sharedInstance.forecastResponse?.list[indexPath.row].imageData {
            if let data = NSData(contentsOf: url) {
                cell.weatherIcon.image = UIImage(data: data as Data)
            }
        }

        
        return cell
    }


}

