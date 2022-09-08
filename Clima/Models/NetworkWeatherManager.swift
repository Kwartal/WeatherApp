//
//  Weather.swift
//  Clima
//
//  Created by Богдан Баринов on 30.08.2022.
//

import Foundation
import CoreLocation

struct NetworkWeatherManager {
    
    func fetchCurrentWeather() {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=f5515b2bb326ee0b85072824c6ce5291"
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            }
        }
        task.resume()
    }
}
