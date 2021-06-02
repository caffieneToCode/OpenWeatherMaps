//
//  CityForecastViewModel.swift
//  Weather
//
//  Created by Ashish Verma on 01/06/21.
//

import Foundation

class CityForecastViewModel {
    var updateView: (() -> Void)?
    var forecastResponse: ForecastResponseModel?
    
    var cityLabelTitle: String?
    var skyStatusLabelTitle: String?
    var currentTemperatureLabelTitle: String?
    var dayTemperatureLabelTitle: String?
    var nightTemperatureLabelTitle: String?
    
    func getForecast(for city: String? = nil) {
        if let city = city {
            ActivityIndicator.start()
            ForecastService.getForecast(for: city) { [weak self] (response) in
                self?.updateData(forecastResponse: response)
            }
        }
    }
    
    func updateData(forecastResponse: ForecastResponseModel?) {
        if let forecastResponse = forecastResponse {
            self.forecastResponse = forecastResponse
            setTitles()
            updateView?()
        }
    }
    
    private func setTitles() {
        cityLabelTitle = forecastResponse?.city?.name
        skyStatusLabelTitle = forecastResponse?.list?.first?.weather?.first?.weatherDescription
        currentTemperatureLabelTitle = String(format: "%0.0f°",
                                                     forecastResponse?.list?.first?.main?.temp ?? "")
        dayTemperatureLabelTitle = String(format: "%0.0f°",
                                                 forecastResponse?.list?.first?.main?.tempMax ?? "")
        nightTemperatureLabelTitle = String(format: "%0.0f°",
                                            forecastResponse?.list?.first?.main?.tempMin ?? "")
    }
}
