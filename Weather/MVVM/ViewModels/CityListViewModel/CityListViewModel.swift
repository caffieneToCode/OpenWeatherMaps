//
//  CityListViewModel.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

class CityListViewModel {
    var updateView: (() -> Void)?
    
    var weatherModels = [WeatherResponseModel]()
    var currentWeatherModel: WeatherResponseModel?
    
    func loadPlaces() {
        if let cities = UserDefaults.standard.object(forKey: "cities") as? [String] {
            for city in cities {
                getWeather(for: city)
            }
        }
    }
    
    func getWeather(for city: String? = nil, coordinates: Coord? = nil) {
        ActivityIndicator.start()
        if let city = city {
            WeatherService.getWeather(for: city) { [weak self] (response) in
                self?.updateData(weatherResponse: response)
            }
        }  else if let coordinates = coordinates {
            WeatherService.getWeather(coordinates: coordinates) { [weak self] (response) in
                self?.updateData(weatherResponse: response)
            }
        }
    }
    
    func updateData(weatherResponse: WeatherResponseModel?) {
        if let weatherResponse = weatherResponse, let name = weatherResponse.name {
            weatherModels.append(weatherResponse)
            updateView?()
            savePlace(with: name)
        }
    }
    
    func addPlace(coord: Coord) {
        getWeather(coordinates: coord)
    }
    
    func savePlace(with name: String) {
        guard var cities = UserDefaults.standard.object(forKey: "cities") as? [String] else {
            var cities = [String]()
            cities.append(name)
            UserDefaults.standard.setValue(cities, forKey: "cities")
            return
        }
        if !cities.contains(name) {
            cities.append(name)
        }
        UserDefaults.standard.setValue(cities, forKey: "cities")
    }
}
