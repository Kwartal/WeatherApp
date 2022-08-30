//
//  ViewController.swift
//  Clima
//
//  Created by Богдан Баринов on 29.08.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // MARK: - UI Elements
    
    private var searchBar = UISearchBar()
    private var locationButton = UIButton()
    private var searchButton = UIButton()
    private var weatherStatusImage = UIImageView()
    private var temperatureLabel = UILabel()
    private var cityLabel = UILabel()

    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setupSubviews()
        configureConstraints()
    }
  
}

extension MainViewController {
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(locationButton)
        view.addSubview(searchButton)
        view.addSubview(weatherStatusImage)
        view.addSubview(temperatureLabel)
        view.addSubview(cityLabel)
    }
    
    private func setupSubviews() {
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        
        temperatureLabel.text = "21"
        temperatureLabel.font = .systemFont(ofSize: 50, weight: .bold)
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textColor = Colors.weatherColor

        
        cityLabel.text = "London"
        cityLabel.font = .systemFont(ofSize: 25, weight: .bold)
        cityLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    private func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.trailing.equalToSuperview().inset(60)
        }
        
        locationButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(searchBar.snp.leading)
            $0.height.equalTo(locationButton.snp.width)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(searchBar.snp.trailing)
            $0.size.equalTo(40)
        }
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(50)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(100)
        }
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(40)
            $0.size.equalTo(50)
        }
    }
    
}
