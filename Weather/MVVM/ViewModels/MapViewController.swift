//
//  MapViewController.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit
import MapKit

protocol PlacePickerDelegate: class {
    func didAddPlaceToList(coord: Coord)
}

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView?
    
    weak var delegate: PlacePickerDelegate?
    var isPresenting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapview()
    }
    
    private func setMapview() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,action: #selector(handleLongPress(gestureReconizer:)))
        longPressGestureRecognizer.minimumPressDuration = 0.3
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.delegate = self
        self.mapView?.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc
    private func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureReconizer.location(in: mapView)
            let locationCoordinate = mapView?.convert(touchLocation,toCoordinateFrom: mapView)
            if let lat = locationCoordinate?.latitude, let lon = locationCoordinate?.longitude {
                print("Tapped at lat: \(lat) lon: \(lon)")
                let coord = Coord(lon: lon, lat: lat)
                shouldAddPlaceToList(coord: coord)
            }
            return
        }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
    }
    
    private func shouldAddPlaceToList(coord: Coord) {
        let alertController = UIAlertController(title: AlertTitles.addPlaceToListTitle,
                                                message: AlertMessages.addPlaceToListMessage,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: ButtonTitles.add, style: .cancel) { [weak self] (action) in
            alertController.dismiss(animated: true, completion: nil)
            self?.isPresenting = false
            self?.addPlaceToList(coord: coord)
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: ButtonTitles.cancel, style: .destructive) { [weak self] (action) in
            alertController.dismiss(animated: true, completion: nil)
            self?.isPresenting = false
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        if !isPresenting {
            isPresenting = true
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func addPlaceToList(coord: Coord) {
        delegate?.didAddPlaceToList(coord: coord)
    }
}
