//
//  FirstViewController.swift
//  Weather
//
//  Created by Timo McFarlane on 04/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: [String] = []
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    let dispatchQueue = DispatchQueue(label: "Dispatch Queue", attributes: [], target: nil)
    
    let cellIdentifier = "cell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (data.count == 0) {
            tableView.separatorStyle = .none
            
            activityIndicatorView.startAnimating()
            
            dispatchQueue.async {
                self.fetchUrl(url: "https://swapi.co/api/people/1");
            }
        }
    }
    
    /*OperationQueue.main.addOperation() {
     self.activityIndicatorView.stopAnimating()
     self.tableView.separatorStyle = .singleLine
     self.data = ["One", "Two", "Three", "Four", "Five"]
     
     self.tableView.reloadData()
     }*/
    
    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            NSLog(resstr!)
            self.activityIndicatorView.stopAnimating()
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        })
    }
    
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        tableView.backgroundView = activityIndicatorView
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "identifier")
        
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "identifier")
        }
        
        cell!.textLabel!.text = self.data[indexPath.row]
        return cell!
    }
    

}
