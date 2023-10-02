//
//  LocationDetailView.swift
//  RickAndMorty
//
//  Created by César Gerace on 29/09/2023.
//

import SwiftUI

struct LocationDetailView: View {
    @State var errorMessage: String?
    
    @State var isLoading = true
    
    @State var residents: [Character] = []
    @State var location: Location? = nil
    @State var shortLocation: ShortLocation? = nil
    
    var body: some View {
        
        VStack {
            if let location = location {
                VStack {
                    Text("Name: " + location.name)
                    Text("Dimension: " + location.dimension)
                    Text("Type: " + location.type)
                    Divider()
                    Text("RESIDENTS")
                        .bold()
                        .font(.title)
                }
                .background(Color.offBlue)
                .foregroundColor(.mainGreen)
            }
            List(residents) { resident in
                ResidentCell(resident: resident)
                    .listRowSeparator(.hidden)
            }
            .background(Color.offBlue)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .padding(.zero)
        }
        .background(Color.offBlue)
        .overlay{
            if isLoading {
                LoadingView()
            }
            if let errorMessage = errorMessage {
                ErrorView(errorMessage: errorMessage)
            }
        }
        .accentColor(.mainBlue)
        .foregroundColor(.mainBlue)
        .navigationTitle("Location")
        .onAppear {
            Task {
                if let location = location {
                    await loadResidents(ids: location.residentsIds)
                }else if let locationId = shortLocation?.id {
                    await loadLocationWith(id: locationId)
                }else {
                    
                }
            }
        }
    }
    
    private func loadLocationWith(id: Int) async {
        self.isLoading = true
        let result = await LocationRepository().getLocationWith(id: "\(id)")
        switch result {
        case .success(let location):
            self.location = location
            self.isLoading = false
            await loadResidents(ids: location.residentsIds)
        case .failure(let error):
            errorMessage = error.rawValue
        }
    }
    
    private func loadResidents(ids: [Int]) async {
        let result = await CharacterRepository().getCharacters(ids: ids)
        switch result {
        case .success(let newResidents):
            self.isLoading = false
            residents = newResidents
        case .failure(let error):
            self.errorMessage = error.rawValue
        }
    }
    
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: Location())
    }
}
