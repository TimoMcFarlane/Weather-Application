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
            WeatherAPI.sharedInstance.fetchForecast(WeatherAPI.getCurrentForecastURL())
        }
    }
    
    
    func didFinishDownloading(_ sender: WeatherAPI) {
        DispatchQueue.main.async(execute: {() in
            if let fetchedForecast = WeatherAPI.sharedInstance.forecastResponse {
                self.forecast = fetchedForecast
            }
            
            // Implement image fetching from this shithole
            
            self.activityIndicatorView.stopAnimating()
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "secondIdentifier")
        
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "secondIdentifier")
        }
        if let fc = self.forecast {
            cell!.textLabel!.text = fc.cod
            //NSLog(String(fc.list[0].coord.lat))
        }
        return cell!
    }


}

