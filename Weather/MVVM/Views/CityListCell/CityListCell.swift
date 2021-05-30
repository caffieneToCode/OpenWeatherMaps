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
    
    var city: City?  {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        cityNameLabel?.text = city?.name ?? ""
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
