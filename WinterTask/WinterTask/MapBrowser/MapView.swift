//
//  MapView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var latitudeStr: String = "30.67"
    @State var longtiudeStr: String = "104.07"
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.67, longitude: 104.07),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.top)
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {}, label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                        })
                        Divider()
                        Button(action: {}, label: {
                            Image(systemName: "paperplane")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                        })
                    }
                    .padding()
                    .frame(width: 50, height: 90)
                    .background(Color(.white))
                }

                Spacer()
                HStack{
                    VStack {
                        HStack {
                            Text("Latitude: ")
                            TextField("Latitude", text: $latitudeStr)
                        }
                        HStack {
                            Text("Longitude: ")
                            TextField("Longitude", text: $longtiudeStr)
                        }
                    }
                    Button(action: {
                        region.center.latitude = Double(latitudeStr)!
                        region.center.longitude = Double(longtiudeStr)!
                    }, label: {
                        Text("Go").font(.title)
                    })
                }
                .padding()
                .background(Color(.white))
                .foregroundColor(.blue)
                .colorMultiply(.white)
                .edgesIgnoringSafeArea(.all)
            }


        }
 
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
