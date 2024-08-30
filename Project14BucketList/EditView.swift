//
//  EditView.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 12/08/24.
//

import SwiftUI
struct EditView : View {
    @Environment(\.dismiss) var dismiss
//    var location : Location
    
//    enum LoadingState {
//        case loading , loaded, failed
//    }
    
    @State private var viewModel : ViewModel ;
    
//    @State private var loadingState = LoadingState.loading
//    @State private var pages : [Page] = [Page]()
//    
//    @State private var name : String
//    @State private var description : String
    
    var onSave : (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name" , text : $viewModel.name)
                    TextField("Description" , text : $viewModel.description)
                }
                Section("Nearby..."){
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages , id : \.pageid){ page in
                            Text(page.title)
                                .font(.headline)
                            + Text(" : ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar{
                Button("Save"){
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    init(location : Location , onSave : @escaping (Location) -> Void ){
        self.viewModel = ViewModel(location: location)
        self.onSave = onSave
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(viewModel.location.latitude)%7C\(viewModel.location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string : urlString ) else {
            print("Bad URL. : \(urlString)")
            return
        }
        
        do {
            let (data , _ ) = try await URLSession.shared.data(from : url)
            
//            we got some data back!
            let items = try JSONDecoder().decode(Result.self , from : data)
            
//            success - convert the array values to the page values
            viewModel.pages = items.query.pages.values.sorted()
            viewModel.loadingState = .loaded
        } catch {
//            if we are still here it means the request has been failed
            viewModel.loadingState = .failed
        }
    }
}

#Preview {
    EditView(location: .example){ _ in }
}
