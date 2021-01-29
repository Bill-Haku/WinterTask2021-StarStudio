//
//  MapKitView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/27.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapKitView : UIViewRepresentable {
    var locationManager = CLLocationManager()
       //locationManager.delegate = self
       /// 导航级别
       /*
        kCLLocationAccuracyBestForNavigation  /// 适合导航
        kCLLocationAccuracyBest               /// 这个是比较推荐的综合来讲，我记得百度也是推荐
        kCLLocationAccuracyNearestTenMeters   /// 10m
        kCLLocationAccuracyHundredMeters      /// 100m
        kCLLocationAccuracyKilometer          /// 1000m
        kCLLocationAccuracyThreeKilometers    /// 3000m
        */
       


    func makeUIView(context: Context) -> MKMapView {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        /// 隔多少米定位一次
        locationManager.distanceFilter = 5
        return MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        //var locationManager = CLLocationManager()
        /*view.showsUserLocation = true
        let coordinate = CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: view.userLocation.location?.coordinate ?? coordinate, span: span)
        view.setRegion(region, animated: true)*/
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        else {
            locationManager.requestAlwaysAuthorization()
        }
        
        
    }
    
    func locationManagerDidChangeAuthorization(manager: CLLocationManager) {
        /// CLAuthorizationStatus
        //var manager = CLLocationManager()
        switch manager.authorizationStatus {
            case .notDetermined:
                print("用户没有决定")
            case .authorizedWhenInUse:
                print("使用App时候允许")
            case .authorizedAlways:
                print("用户始终允许")
            case.denied:
                print("定位关闭或者对此APP授权为never")
            /// 这种情况下你可以判断是定位关闭还是拒绝
            /// 根据locationServicesEnabled方法
            case .restricted:
                print("访问受限")
            @unknown default:
                print("不确定的类型")
            }
    }
    
    /// 地理编码
    /// - Parameter addressString: addressString description
    private func geocodeUserAddress(addressString:String) {
        var locationGeocoder = CLGeocoder()
        locationGeocoder.geocodeAddressString(addressString){(placeMark, error) in
                 
            print("地理编码纬度:",placeMark?.first?.location?.coordinate.latitude ?? "")
            print("地理编码经度:",placeMark?.first?.location?.coordinate.longitude ?? "")
        }
    }
    
    private func reverseGeocodeLocation(location:CLLocation){
             
        var locationGeocoder = CLGeocoder()
        locationGeocoder.reverseGeocodeLocation(location){(placemark, error) in
                 
            /// city, eg. Cupertino
            print("反地理编码-locality：" + (placemark?.first?.locality ?? ""))
            /// eg. Lake Tahoe
            print("反地理编码-inlandWater：" + (placemark?.first?.inlandWater ?? ""))
            /// neighborhood, common name, eg. Mission District
            print("反地理编码-subLocality：" + (placemark?.first?.subLocality ?? ""))
            /// eg. CA
            print("反地理编码-administrativeArea：" + (placemark?.first?.administrativeArea ?? ""))
            /// eg. Santa Clara
            print("反地理编码-subAdministrativeArea：" + (placemark?.first?.subAdministrativeArea ?? ""))
            /// eg. Pacific Ocean
            print("反地理编码-ocean：" + (placemark?.first?.ocean ?? ""))
            /// eg. Golden Gate Park
            print("反地理编码-areasOfInterest：",(placemark?.first?.areasOfInterest ?? [""]))
            /// 具体街道信息
            print("反地理编码-thoroughfare：",(placemark?.first?.thoroughfare ?? ""))
                 
            /// 回调得到的位置信息
            guard let locationPlacemark = placemark?.first else{return}
            //guard let locationSuccess = self.locationSuccess else{return}
            //locationSuccess(locationPlacemark)
            /// 地理编码位置，看能不能得到正确经纬度
            self.geocodeUserAddress(addressString: (placemark?.first?.thoroughfare ?? ""))
        }
    }
    /// 获取更新到的用户位置
    /// - Parameters:
    ///   - manager: manager description
    ///   - locations: locations description
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        print("纬度：" + String(locations.first?.coordinate.latitude ?? 0))
        print("经度：" + String(locations.first?.coordinate.longitude ?? 0))
        print("海拔：" + String(locations.first?.altitude ?? 0))
        print("航向：" + String(locations.first?.course ?? 0))
        print("速度：" + String(locations.first?.speed ?? 0))
             
        /*
         纬度34.227653802098665
         经度108.88102549186357
         海拔410.17602920532227
         航向-1.0
         速度-1.0
         */
        /// 反编码得到具体的位置信息
        guard let coordinate = locations.first else { return  }
        reverseGeocodeLocation(location: coordinate )
    }
}

struct MapKitView_Previews: PreviewProvider {
    static var previews: some View {
        MapKitView()
    }
}
