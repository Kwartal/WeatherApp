//
//  ViewController+alertController.swift
//  Clima
//
//  Created by Богдан Баринов on 08.09.2022.
//

import Foundation
import UIKit

extension WeatherViewController {
    func presentSearchAlertController(with title: String?, message: String?, style: UIAlertController.Style, complitionHandler: @escaping (String) -> Void) {
        let searchAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        searchAlertController.addTextField { tf in
            let cities = ["Moscow", "Stambul", "Paris", "New York"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Seatch", style: .default) { action in
            let textField = searchAlertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
//                self.networkWeatherManager.fetchCurrentWeather(for: cityName)
                let city = cityName.split(separator: " ").joined(separator: "%20")
                complitionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        searchAlertController.addAction(search)
        searchAlertController.addAction(cancel)
        present(searchAlertController, animated: true, completion: nil)
    }
}
