//
//  WeatherService.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

class WeatherService {
    static func getWeather(for city: String? = nil, lat: String? = nil, lon: String? = nil) {
        NetworkManager.request(router: .weather(city: city, lat: lat, lon: lon)) { (result: Result<WeatherResponseModel, Error>) in
            switch result {
            case .success:
                print("Success: getWeather()")
            case .failure:
                print("Failure: getWeather()")
            }
        }
    }
}
