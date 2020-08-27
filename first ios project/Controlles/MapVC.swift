//
//  MapVC.swift
//  first ios project
//
//  Created by IOS on 8/8/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBook

protocol SetAddressDelegate : class {
    func setAddress(_ address : String)
}

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressLbl: UILabel!
    let locationManager = CLLocationManager()
    let latitudinalMeters : Double = 10000
    let longitudinalMeters : Double = 10000
    var previousLocation : CLLocation?
    let geoCoder = CLGeocoder()
    weak var delegate : SetAddressDelegate?
  //  var currentCoordinate = CLLocationCoordinate2D()
   // let location = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(rightHandAction))
    }
    
    @objc
    func rightHandAction() {
        delegate?.setAddress(addressLbl.text ?? "address")
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthoriation()
        } else {
            showAlert()
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func  checkLocationAuthoriation() {
        switch CLLocationManager.authorizationStatus() {
        
        case .authorizedWhenInUse:
            startTrackUserLocation()
            break

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
            
        default :
            showAlert()
            break
        }
    }
    
    func startTrackUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        getNameOfLocation(lat: mapView.centerCoordinate.latitude, long: mapView.centerCoordinate.longitude)
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        print(latitude)
        print(longitude)
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "ERROR", message: "Please turn on your location service", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MapVC: CLLocationManagerDelegate
{
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
    mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthoriation()
    }
}

extension MapVC : MKMapViewDelegate
{
    private func getNameOfLocation(lat:CLLocationDegrees,long:CLLocationDegrees) {
        let center = getCenterLocation(for: mapView)
        
        // let location = CLLocation(latitude: lat, longitude: long)
        
        // Geocode Location
        geoCoder.reverseGeocodeLocation(center) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if error != nil {
            addressLbl.text = "Unable to Find Address for Location"
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
               // let streetNumber = placemark.subThoroughfare ?? "streetNumber"
                let country = placemark.country ?? "country"
                let city = placemark.locality ?? "city"
                let street = placemark.thoroughfare ?? "street"
                addressLbl.text =  "\(country) , \(city) , \(street)"
            }
        }
   //func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
   // getNameOfLocation(lat: mapView.centerCoordinate.latitude, long: mapView.centerCoordinate.longitude)
        /*let center = getCenterLocation(for: mapView)
        guard previousLocation == self.previousLocation else { return }
        guard center.distance(from: previousLocation!) > 50 else {return}
        previousLocation = center
        geoCoder.reverseGeocodeLocation(center, completionHandler: {[weak self] (placeMarks, error) in
            guard let self = self else {return}
            if let _ = error {
                print("error")
            }
            guard let placeMark = placeMarks?.first else {return}
            let streetNumber = placeMark.subThoroughfare ?? "streetNumber"
            let country = placeMark.country ?? "country"
            DispatchQueue.main.sync {
                self.addressLbl.text = "\(streetNumber) \(country)"
            }
        })
    }*/
    
   
    }
}
//}
