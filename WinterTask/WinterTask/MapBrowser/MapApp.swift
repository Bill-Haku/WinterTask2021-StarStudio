//
//  MapKitView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/27.
//

import SwiftUI
import MapKit
import CoreLocation

var manager: LocationManager!
var curLatitude: CLLocationDegrees = 0
var curLongitude: CLLocationDegrees = 0

class LocationManager: NSObject {
    static let shared = LocationManager()
    var getLocationHandle: ((_ success: Bool, _ latitude: Double, _ longitude: Double) -> Void)?
    var getAuthHandle: ((_ success: Bool) -> Void)?
    private var locationManager: CLLocationManager!
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    // Check if the device has location service
    func hasLocationService() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    // Check if the App has location permission
    func hasLocationPermission() -> Bool {
        switch locationPermission() {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        default:
            break
        }
        return false
    }
    // Authorization of get current location
    func locationPermission() -> CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            let status: CLAuthorizationStatus = locationManager.authorizationStatus
            print("location authorizationStatus is \(status.rawValue)")
            return status
        } else {
            let status = CLLocationManager.authorizationStatus()
            print("location authorizationStatus is \(status.rawValue)")
            return status
        }
    }
    //Get the authorization and get result in 'didChangeAuthorization'
    func requestLocationAuthorizaiton() {
        locationManager.requestWhenInUseAuthorization()
    }
    //Get current location
    func requestLocation() {
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
   //function to get the result of authorization before iOS 14.0
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleChangedAuthorization()
    }
    //function to get the result of authorization at iOS 14.0
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleChangedAuthorization()
    }
    private func handleChangedAuthorization() {
        if let block = getAuthHandle, locationPermission() != .notDetermined {
            if hasLocationPermission() {
                block(true)
            } else {
                block(false)
            }
        }
    }
    //get the latitude and longtitude
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loction = locations.last {
            print("latitude: \(loction.coordinate.latitude)   longitude:\(loction.coordinate.longitude)")
            curLatitude = loction.coordinate.latitude
            curLongitude = loction.coordinate.longitude
            if let block = getLocationHandle {
                block(true, loction.coordinate.latitude, loction.coordinate.longitude)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let block = getLocationHandle {
            block(false, 0, 0)
        }
        print("get location failed. error:\(error.localizedDescription)")
    }
}


//TEST
/*@IBAction func testLocation(_ sender: Any) {
    if CLLocationManager.locationServicesEnabled() {
        print("设备有定位服务")
        manager = LocationManager.shared
        manager.getAuthHandle = { [weak self] (success) in
            print("获取权限:\(success)")
        }
        if manager.hasLocationPermission() {
            manager.requestLocation()
            manager.getLocationHandle = { (success,latitude, longitude) in
                print("获得location \(success), latitude:\(latitude)  longitude:\(longitude)")
            }
        } else {
            manager.requestLocationAuthorizaiton()
        }
    } else {
        print("设备没有定位服务")
        let alter = UIAlertController(title: "Location is Disabled", message: "To use location, go to your settings\nApp > Privacy > Location Services", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
}*/

/*
 kCLLocationAccuracyBestForNavigation  /// Best for navigation
 kCLLocationAccuracyBest               /// Recommended
 kCLLocationAccuracyNearestTenMeters   /// 10m
 kCLLocationAccuracyHundredMeters      /// 100m
 kCLLocationAccuracyKilometer          /// 1000m
 kCLLocationAccuracyThreeKilometers    /// 3000m
 */

