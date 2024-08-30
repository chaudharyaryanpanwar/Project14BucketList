//
//  IntegratingMapKitWithSwiftUI.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 12/08/24.
//

import MapKit
import SwiftUI

struct IntegratingMapKitWithSwiftUI: View {
    var body: some View {
        Map(interactionModes: [])
//            .mapStyle(.imagery)
//            .mapStyle(.hybrid)
            .mapStyle(.hybrid(elevation: .realistic))
    }
}

struct ContentView2 : View {
    
    let position1 = MapCameraPosition.region(
        MKCoordinateRegion(
            center : CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275) ,
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center : CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275) ,
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    
    
    var body: some View {
//        Map(initialPosition: position)
        VStack {
            Map(position : $position)
//                .onMapCameraChange { context in
//                    print(context.region)
//                }
                .onMapCameraChange(frequency: .continuous){ context in
                    print(context.region)
                }
            
            HStack(spacing : 50) {
                Button("Paris"){
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center : CLLocationCoordinate2D(latitude: 48.8566 , longitude: 2.3522)  ,
                            span : MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
                
                Button("Tokyo"){
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center : CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922) ,
                            span : MKCoordinateSpan(latitudeDelta: 1 , longitudeDelta: 1)
                        )
                    )
                }
                Button("Shamli"){
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center : CLLocationCoordinate2D(latitude: 29.312707119430463, longitude: 77.2972842094113) ,
                            span : MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
            }
        }
    }
}


struct Location1 : Identifiable {
    let id = UUID()
    var name : String
    var coordinate : CLLocationCoordinate2D
}


struct ContentView3 : View {
    
    let locations = [
        Location1(name : "Buckingham Place" , coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)) ,
        Location1(name : "Tower of Lodon" , coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)) ,
        
    ]
    
    var body: some View {
        Map {
            ForEach(locations) { location in
//                Marker(location.name, coordinate: location.coordinate)
                Annotation(location.name, coordinate: location.coordinate) {
                    Text(location.name)
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                .annotationTitles(.hidden)
            }
        }
    }
}


struct LearningMapReader : View {
    var body: some View {
        MapReader { proxy in
            Map()
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local){
                        print(coordinate)
                    }
                }
        }
    }
}
#Preview {
        IntegratingMapKitWithSwiftUI()
}
#Preview {
    ContentView2()
}

#Preview {
    ContentView3()
}

#Preview {
    LearningMapReader()
}
