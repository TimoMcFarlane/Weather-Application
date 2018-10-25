//
//  FirstViewController.swift
//  Weather
//
//  Created by Timo McFarlane on 04/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WeatherAPI.setActiveOption(option: (tableView.cellForRow(at: indexPath)?.textLabel!.text)!)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherAPI.getWeatherOptions().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdIdentifier")!
        cell.textLabel?.text = WeatherAPI.getWeatherOptions()[indexPath.row]
        
        return cell
    }
    
}


