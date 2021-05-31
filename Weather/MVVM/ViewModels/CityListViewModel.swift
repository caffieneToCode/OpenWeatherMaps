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
    
    func getWeather(for city: String? = nil, coordinates: Coord? = nil) {
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
        if let weatherResponse = weatherResponse {
            weatherModels.append(weatherResponse)
            updateView?()
        }
    }
    
    func addPlace(coord: Coord) {
        getWeather(coordinates: coord)
    }
}
