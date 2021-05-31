//
//  WeatherService.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

class WeatherService {
    static func getWeather(for city: String? = nil, coordinates: Coord? = nil, completion: @escaping (_ response: WeatherResponseModel) -> Void) {
        NetworkManager.request(router: .weather(city: city, coordinates: coordinates)) { (result: Result<WeatherResponseModel, Error>) in
            switch result {
            case .success(let response):
                print("Success: getWeather()")
                completion(response)
            case .failure:
                print("Failure: getWeather()")
            }
        }
    }
}
