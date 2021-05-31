//
//  CityListViewController.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit

class CityListViewController: UIViewController {
    @IBOutlet weak var citiesCollectionView: UICollectionView?
    
    var cityListViewModel = CityListViewModel()
    private let cityListCellIdentifier = "CityListCell"
    private let cellHeight: CGFloat = 80.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        initViewModel()
//        getWeather()
//        getForecast()
    }
    
    private func configureCollectionView() {
        citiesCollectionView?.delegate = self
        citiesCollectionView?.dataSource = self
        citiesCollectionView?.register(UINib(nibName: cityListCellIdentifier, bundle: nil), forCellWithReuseIdentifier: cityListCellIdentifier)
    }
    
    private func initViewModel() {
        cityListViewModel.updateView = { [weak self] in
            DispatchQueue.main.async {
                self?.citiesCollectionView?.reloadData()
            }
        }
    }
    
    private func getWeather() {
        cityListViewModel.getWeather()
    }
    
    private func getForecast() {
        ForecastService.getForecast(for: "pune")
    }
    
    private func getHourlyForecast() {
        ForecastService.getHourlyForecast(for: "pune")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapViewController = segue.destination as? MapViewController {
            mapViewController.delegate = self
        }
    }
}

extension CityListViewController: UICollectionViewDelegate {
    
}

extension CityListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (cityListViewModel.weatherModels.count == 0) {
            citiesCollectionView?.setEmptyMessage(AlertMessages.noPlacesToShow)
        } else {
            citiesCollectionView?.restore()
        }
        return cityListViewModel.weatherModels.count
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cityListCellIdentifier, for: indexPath) as? CityListCell {
            cell.weatherModel = cityListViewModel.weatherModels[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        return CGSize(width: width, height: cellHeight)
    }
}

extension CityListViewController: PlacePickerDelegate {
    func didAddPlaceToList(coord: Coord) {
        cityListViewModel.addPlace(coord: coord)
    }
}
