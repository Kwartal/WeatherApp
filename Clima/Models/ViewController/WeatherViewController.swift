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
    
    private var networkWeatherManager = NetworkWeatherManager()
    private let locationManager = CLLocationManager()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
            
            print(currentWeather.cityName)
        }
        networkWeatherManager.delegate = self
        backgroundSettings()
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
        view.addSubview(feelsLikeTemperatureLabel)
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
        
        feelsLikeTemperatureLabel.text = "Feelslike " + "25" + "℃"
        feelsLikeTemperatureLabel.font = .systemFont(ofSize: 18, weight: .regular)
        feelsLikeTemperatureLabel.adjustsFontSizeToFitWidth = true
        feelsLikeTemperatureLabel.textColor = Colors.weatherColor
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
            $0.width.equalTo(120)
            $0.height.equalTo(60)
        }
        
        
        feelsLikeTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            $0.trailing.equalTo(temperatureLabel)
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(searchButton).offset(5)
            $0.trailing.equalTo(searchButton.snp.leading).offset(5)
            $0.height.equalTo(30)
        }
    }
    
    // MARK: - Private Methods
    private func backgroundSettings() {
        view.backgroundColor = .systemBackground
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    @objc private func searchButtonPressed() {
        presentSearchAlertController(with: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(for: city)
        }
    }
    
    private func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.weatherStatusImage.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}

extension WeatherViewController: NetworkWeatherManagerDelegate {
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather) {
        print(currentWeather.cityName)
    }
}

