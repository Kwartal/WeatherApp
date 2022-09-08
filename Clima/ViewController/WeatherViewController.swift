//
//  WeatherController.swift
//  Clima
//
//  Created by Богдан Баринов on 29.08.2022.
//

import UIKit
import SnapKit
import CoreLocation

class WeatherViewController: UIViewController {
    // MARK: - UI Elements
    
    private var locationButton = UIButton()
    private var searchButton = UIButton()
    private var weatherStatusImage = UIImageView()
    private var temperatureLabel = UILabel()
    private var feelsLikeTemperatureLabel = UILabel()
    private var cityLabel = UILabel()
    
    let locationManager = CLLocationManager()
    

    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        addSubviews()
        setupSubviews()
        configureConstraints()
        

    }
  
}

extension WeatherViewController {
    
    private func addSubviews() {
        view.addSubview(locationButton)
        view.addSubview(searchButton)
        view.addSubview(weatherStatusImage)
        view.addSubview(temperatureLabel)
        view.addSubview(cityLabel)
        
    }
    
    private func setupSubviews() {

        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
        weatherStatusImage.image = UIImage(systemName: "cloud.drizzle") 
        weatherStatusImage.tintColor = .label
        
        temperatureLabel.text = "21" + "℃"
        temperatureLabel.font = .systemFont(ofSize: 50, weight: .bold)
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textColor = Colors.weatherColor

        
        cityLabel.text = "London"
        cityLabel.font = .systemFont(ofSize: 30, weight: .bold)
        cityLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    private func configureConstraints() {
        
        locationButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(40)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }
        
        weatherStatusImage.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(30)
            $0.size.equalTo(150)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherStatusImage.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(150)
        }
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(30)
        }
    }
    
    @objc private func searchButtonPressed() {
        print("Search button pressed")
    }
}


