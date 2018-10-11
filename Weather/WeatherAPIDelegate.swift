//
//  WeatherAPIDelegate.swift
//  Weather
//
//  Created by Timo McFarlane on 09/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import Foundation

protocol WeatherAPIDelegate {
    func didFinishDownloading(_ sender: WeatherAPI)
}
