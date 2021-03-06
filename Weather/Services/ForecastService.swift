//
//  ForecastService.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

class ForecastService {
    static func getForecast(for city: String, completion: @escaping (_ response: ForecastResponseModel) -> Void) {
        NetworkManager.request(router: .forecast(city: city)) { (result: Result<ForecastResponseModel, Error>) in
            switch result {
            case .success(let response):
                print("Success: getForecast()")
                completion(response)
            case .failure:
                print("Failure: getForecast()")
            }
        }
    }
    
    static func getHourlyForecast(for city: String) {
        NetworkManager.request(router: .hourlyForecast(city: city)) { (result: Result<ForecastResponseModel, Error>) in
            switch result {
            case .success:
                print("Success: getHourlyForecast()")
            case .failure:
                print("Failure: getHourlyForecast()")
            }
        }
    }
}
