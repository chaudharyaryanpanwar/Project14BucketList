//
//  ContentView.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 11/08/24.
//

import MapKit
import SwiftUI

struct ContentView : View {
    
    @State private var viewModel = ViewModel()
    let startPosition = MapCameraPosition.region (
        MKCoordinateRegion(
            center : CLLocationCoordinate2D(latitude: 56, longitude: -3) ,
            span : MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    var body: some View {
        Group {
            if viewModel.isUnlocked {
                MapReader { proxy in
                    Map(initialPosition: startPosition){
                        ForEach(viewModel.locations){ location in
                            Annotation(location.name , coordinate: location.coordinate ){
                                Image(systemName : "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width : 44 , height : 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    
                    .sheet(item: $viewModel.selectedPlace, content: { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    })
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position , from : .local){
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .mapStyle(viewModel.mapStyle)
                    .overlay(alignment: .bottom ){
                    VStack {
                        Text("Select a Map Style")
                            .bold()
                        HStack {
                                Spacer()
                                Button("Standard"){
                                    viewModel.setMapStyle(mapStyle: .standard)
                                }
                                .padding()
                                .padding(.horizontal)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(.capsule)
                                Spacer()
                                Button("Hybrid"){
                                    viewModel.setMapStyle(mapStyle: .hybrid)
                                }
                                .padding()
                                .padding(.horizontal)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(.capsule)
                                Spacer()
        
                            
                        }
                    }
                    .padding([.horizontal , .top])
                    .background(.ultraThinMaterial)
                    .frame(maxWidth: .infinity)
                    
                    
                   }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Toggle("Map Style", isOn: $viewModel.map)
                    }
                }
            } else {
                Button("Unlock Places" , action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert("Authentication Error", isPresented: $viewModel.isError) {
            Text(viewModel.errorMsg ?? "Authentication Failed")
            Button("ok") {
                
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
