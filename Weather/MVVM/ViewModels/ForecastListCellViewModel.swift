//
//  ForecastListModel.swift
//  Weather
//
//  Created by Ashish Verma on 02/06/21.
//

import Foundation

struct ForecastListCellViewModel {
    var timeLabelTitle: String?
    var temperatureLabelTitle: String?
    var humidityLabelTitle: String?
    var rainChancesLabelTitle: String?
    var windSpeedLabelTitle: String?
    
    var list: List?
    
    init(with listObject: List) {
        list = listObject
        configureTitles()
    }

    mutating private func configureTitles() {
        timeLabelTitle = convertDateFormat(from: list?.dtTxt ?? "")
        temperatureLabelTitle = "\(String(format: "%0.0f", list?.main?.temp ?? 0.0))°"
        humidityLabelTitle = "\(String(list?.main?.humidity ?? 0))%"
        rainChancesLabelTitle = list?.weather?.first?.weatherDescription?.capitalized
        windSpeedLabelTitle = "\(String(format: "%0.0f", list?.wind?.speed ?? 0.0)) m/s"
    }
    
    func convertDateFormat(from string: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let oldDate = olDateFormatter.date(from: string) ?? Date()
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "hh:mm a"
        return newDateFormatter.string(from: oldDate)
    }
}
