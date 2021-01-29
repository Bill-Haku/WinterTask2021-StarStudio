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

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        let coordinate = CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: view.userLocation.location?.coordinate ?? coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapKitView_Previews: PreviewProvider {
    static var previews: some View {
        MapKitView()
    }
}
