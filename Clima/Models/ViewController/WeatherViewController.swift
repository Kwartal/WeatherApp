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
    
    private var searchButton = UIButton()
    private var weatherStatusImage = UIImageView()
    private var temperatureLabel = UILabel()
    private var feelsLikeTemperatureLabel = UILabel()
    private var cityLabel = UILabel()
    
    var networkWeatherManager = NetworkWeatherManager()
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
            
            print(currentWeather.cityName)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
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
        view.addSubview(searchButton)
        view.addSubview(weatherStatusImage)
        view.addSubview(temperatureLabel)
        view.addSubview(cityLabel)
        view.addSubview(feelsLikeTemperatureLabel)
    }
    
    private func setupSubviews() {
        
        
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
    
        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }
        
        weatherStatusImage.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(30)
            $0.size.equalTo(200)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherStatusImage.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(100)
        }
        
        
        feelsLikeTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom)
            $0.trailing.equalTo(temperatureLabel)
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(searchButton)
            $0.trailing.equalTo(searchButton.snp.leading).inset(5)
            $0.height.equalTo(30)
        }
        
    }
    
    //MARK: - Private methods
    
    private func backgroundSettings() {
        view.backgroundColor = .systemBackground
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    @objc private func searchButtonPressed() {
        presentSearchAlertController(with: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestTupe: .cityName(city: city))
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

// MARK: - CLLoacationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestTupe: .coordinate(latitude: latitude, longitude: longitude))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

