//
//  CityListCellCollectionViewCell.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit

class CityListCell: UICollectionViewCell {
    @IBOutlet weak var cityNameLabel: UILabel?
    @IBOutlet weak var curentTemperatureLabel: UILabel?
    
    var weatherModel: WeatherResponseModel?  {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        cityNameLabel?.text = weatherModel?.name ?? ""
        if let temperature = weatherModel?.main?.temp {
            let temperatureString = String(format: "%0.0f", temperature)
            curentTemperatureLabel?.text = "\(temperatureString)°"
        }
    }
}
