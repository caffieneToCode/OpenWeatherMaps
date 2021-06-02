//
//  ForecastListCell.swift
//  Weather
//
//  Created by Ashish Verma on 01/06/21.
//

import UIKit

class ForecastListCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?
    @IBOutlet weak var rainChancesLabel: UILabel?
    @IBOutlet weak var windSpeedLabel: UILabel?
    
    var forecastListModel: ForecastListCellViewModel? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        self.timeLabel?.text = forecastListModel?.timeLabelTitle
        self.temperatureLabel?.text = forecastListModel?.temperatureLabelTitle
        self.humidityLabel?.text = forecastListModel?.humidityLabelTitle
        self.rainChancesLabel?.text = forecastListModel?.rainChancesLabelTitle
        self.windSpeedLabel?.text = forecastListModel?.windSpeedLabelTitle
    }
}
