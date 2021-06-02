//
//  CityListViewController.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit

class CityListViewController: UIViewController {
    @IBOutlet weak var citiesCollectionView: UICollectionView?
    
    private let cityListCellIdentifier = "CityListCell"
    private let cellHeight: CGFloat = 80.0
    
    var cityListViewModel: CityListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        initViewModel()
        cityListViewModel?.loadPlaces()
    }
    
    private func configureCollectionView() {
        citiesCollectionView?.delegate = self
        citiesCollectionView?.dataSource = self
        citiesCollectionView?.register(UINib(nibName: cityListCellIdentifier, bundle: nil),
                                       forCellWithReuseIdentifier: cityListCellIdentifier)
    }
    
    private func initViewModel() {
        cityListViewModel = CityListViewModel()
        cityListViewModel?.updateView = { [weak self] in
            DispatchQueue.main.async {
                self?.citiesCollectionView?.reloadData()
            }
        }
    }
    // TODO: - Modify or remove this
    private func getWeather() {
        ActivityIndicator.start()
        cityListViewModel?.getWeather()
    }
}

// MARK: - NavigationController implementation
extension CityListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapViewController = segue.destination as? MapViewController {
            mapViewController.delegate = self
        }
        if let cityForecastViewController = segue.destination as? CityForecastViewController {
            cityForecastViewController.city = cityListViewModel?.currentWeatherModel?.name
        }
    }
}

// MARK: - UICollectionViewDelegate implementation
extension CityListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cityListViewModel?.currentWeatherModel = cityListViewModel?.weatherModels[indexPath.row]
        self.performSegue(withIdentifier: "ForecastSegue", sender: self)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout implementation
extension CityListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (cityListViewModel?.weatherModels.count == 0) {
            citiesCollectionView?.setEmptyMessage(InforMessages.noPlacesToShow)
        } else {
            citiesCollectionView?.restore()
        }
        return cityListViewModel?.weatherModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cityListCellIdentifier,
                                                         for: indexPath) as? CityListCell {
            if let weatherModel = cityListViewModel?.weatherModels[indexPath.item] {
                let cityListCellViewModel = CityListCellViewModel(with: weatherModel)
                cell.cityListCellViewModel = cityListCellViewModel
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        return CGSize(width: width, height: cellHeight)
    }
}

// MARK: - PlacePickerDelegate implementation
extension CityListViewController: PlacePickerDelegate {
    func didAddPlaceToList(coord: Coord) {
        cityListViewModel?.addPlace(coord: coord)
    }
}
