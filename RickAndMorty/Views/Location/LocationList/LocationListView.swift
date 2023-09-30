//
//  LocationsListView.swift
//  RickAndMorty
//
//  Created by César Gerace on 29/09/2023.
//

import SwiftUI

struct LocationsListView: View {
    @State var errorMessage: String? = nil
    @State var initialLoading = true
    @State var hasMoreLocations = true
    
    @State var locations = [Location]()
    @State var page = 1
    
    var body: some View {
        
        NavigationView() {
            List(locations) { location in
                LocationCell(location: location)
                .listRowSeparator(.hidden)
                .onAppear(){
                    if hasMoreLocations && location == locations[locations.count - 3] {
                        page += 1
                        Task {
                            await loadLocations(page: page)
                        }
                    }
                }
            }
            .background(.black)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .padding(.zero)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                }
            }
            
        }
        .overlay{
            if initialLoading {
                LoadingView()
            }
            if let errorMessage = errorMessage {
                ErrorView(errorMessage: errorMessage)
            }
        }
        .accentColor(.mainBlue)
        .foregroundColor(.mainBlue)
        .onAppear{
            Task {
                await loadLocations()
            }
        }
        
    }
    
    private func loadLocations(page: Int = 1) async {
        let result = await LocationRepository().getLocations(page: page)
        switch result {
        case .success(let newLocations):
            initialLoading = false
            hasMoreLocations = newLocations.count >= 20
            locations.append(contentsOf: newLocations)
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }

}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}
