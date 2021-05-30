//
//  CityListViewController.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit

class CityListViewController: UIViewController {
    @IBOutlet weak var citiesCollectionView: UICollectionView?
    
    private var cityListViewModel = CityListViewModel()
    private let cityListCellIdentifier = "CityListCell"
    private let cellHeight: CGFloat = 80.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getWeather()
        getForecast()
    }
    
    private func configureCollectionView() {
        citiesCollectionView?.delegate = self
        citiesCollectionView?.dataSource = self
        citiesCollectionView?.register(UINib(nibName: cityListCellIdentifier, bundle: nil), forCellWithReuseIdentifier: cityListCellIdentifier)
    }
    
    private func getWeather() {
        WeatherService.getWeather(for: "pune", lat: "0", lon: "0")
    }
    
    private func getForecast() {
        ForecastService.getForecast(for: "pune")
    }
    
    private func getHourlyForecast() {
        ForecastService.getHourlyForecast(for: "pune")
    }
}

extension CityListViewController: UICollectionViewDelegate {
    
}

extension CityListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (cityListViewModel.cities.count == 0) {
            citiesCollectionView?.setEmptyMessage(AlertMessages.noPlacesToShow)
        } else {
            citiesCollectionView?.restore()
        }
        return cityListViewModel.cities.count
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cityListCellIdentifier, for: indexPath) as? CityListCell {
            cell.city = cityListViewModel.cities[indexPath.item]
            cell.cityNameLabel?.text = "Pune"
            cell.curentTemperatureLabel?.text = "31°"
            return cell

        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        return CGSize(width: width, height: cellHeight)
    }
}
