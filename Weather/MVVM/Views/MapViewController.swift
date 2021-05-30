//
//  MapViewController.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapview()
    }
    
    func setMapview() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,action: #selector(handleLongPress(gestureReconizer:)))
        longPressGestureRecognizer.minimumPressDuration = 0.3
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.delegate = self
        self.mapView?.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureReconizer.location(in: mapView)
            let locationCoordinate = mapView?.convert(touchLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(locationCoordinate?.latitude ?? 0.0) long: \(locationCoordinate?.longitude ?? 0.0)")
            return
        }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
    }
}
