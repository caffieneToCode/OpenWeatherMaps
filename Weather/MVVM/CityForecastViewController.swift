//
//  CityForecastViewController.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit

class CityForecastViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var skyStatusLabel: UILabel?
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var dayTemperatureLabel: UILabel?
    @IBOutlet weak var nightTemperatureLabel: UILabel?
    @IBOutlet weak var forecastTableView: UITableView?
    
    private let forecastListCellIdentifier = "ForecastListCell"
    private let cellHeight: CGFloat = 50.0
    
    var city: String?
    var cityForecastViewModel: CityForecastViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        initViewModel()
        getForecast()
    }
    
    private func configureTableView() {
        forecastTableView?.delegate = self
        forecastTableView?.dataSource = self
        forecastTableView?.register(UINib(nibName: forecastListCellIdentifier, bundle: nil),
                                    forCellReuseIdentifier: forecastListCellIdentifier)
    }
    
    private func initViewModel() {
        cityForecastViewModel = CityForecastViewModel()
        cityForecastViewModel?.updateView = { [weak self] in
            DispatchQueue.main.async {
                self?.cityLabel?.text = self?.cityForecastViewModel?.cityLabelTitle
                self?.skyStatusLabel?.text = self?.cityForecastViewModel?.skyStatusLabelTitle
                self?.currentTemperatureLabel?.text = self?.cityForecastViewModel?.currentTemperatureLabelTitle
                self?.dayTemperatureLabel?.text = self?.cityForecastViewModel?.dayTemperatureLabelTitle
                self?.nightTemperatureLabel?.text = self?.cityForecastViewModel?.nightTemperatureLabelTitle
                self?.forecastTableView?.reloadData()
            }
        }
    }
    
    private func getForecast() {
        if let city = city {
            cityForecastViewModel?.getForecast(for: city)
        }
    }
}

extension CityForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityForecastViewModel?.forecastResponse?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: forecastListCellIdentifier) as? ForecastListCell {
            cell.layer.backgroundColor = UIColor.clear.cgColor
            if let list = cityForecastViewModel?.forecastResponse?.list?[indexPath.row] {
                let forecastListModel = ForecastListCellViewModel(with: list)
                cell.forecastListModel = forecastListModel
                return cell
            }
        }
        return UITableViewCell()
    }
}
