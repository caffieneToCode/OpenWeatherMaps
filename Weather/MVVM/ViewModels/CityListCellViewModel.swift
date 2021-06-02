//
//  CityListCellViewModel.swift
//  Weather
//
//  Created by Ashish Verma on 02/06/21.
//

import Foundation

struct CityListCellViewModel {
    var cityNameLabelTitle: String?
    var curentTemperatureLabelTitle: String?
    
    var weatherResponseModel: WeatherResponseModel?
    
    init(with weatherResponseObject: WeatherResponseModel) {
        weatherResponseModel = weatherResponseObject
        configureTitles()
    }
    
    mutating private func configureTitles() {
        cityNameLabelTitle = weatherResponseModel?.name ?? ""
        curentTemperatureLabelTitle = "\(String(format: "%0.0f", weatherResponseModel?.main?.temp ?? 0.0))°"
    }
}
