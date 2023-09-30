//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import SwiftUI
import CachedAsyncImage

struct CharacterDetailView: View {
    @State var isLoading = false
    let character: Character
    @Binding var favoriteIds: [Int]
    
    private var isFavorite: Bool {
        get {
            favoriteIds.contains(character.id)
        }
    }
    
    @State var location: Location?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            ZStack {
                
                CachedAsyncImage(url: character.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                
                Spacer(minLength: UIScreen.main.bounds.width)
                    .background(Color.offBlack.opacity(0.8))
                
                VStack {
                    Spacer()
                    Text(character.name)
                        .font(.title)
                        .padding(.top)
                }
            }
            
            
            Text("Gender: \(character.gender.rawValue)")
            
            Text("Species: \(character.species)")
            
            Text("Origin: \(character.originalLocation.name)")
            
            Text("Total appearances: \(character.appearances) episodes")
            
            Divider()
            
            NavigationLink(destination: LocationDetailView(shortLocation: character.currentLocation)){
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Last Seen On ")
                        Text(character.currentLocation.name)
                        Divider()
                        Text("OPEN LOCATION")
                            .font(.title)
                    }
                    Spacer()
                }
            }
            Spacer(minLength: 100)
            
        }
        .background(Color.offBlue)
        .foregroundColor(.mainGreen)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if isFavorite {
                        favoriteIds = favoriteIds.filter{$0 != character.id}
                    }else {
                        favoriteIds = favoriteIds + [character.id]
                    }
                })
                {Image(systemName: isFavorite ? "heart.fill" : "heart")}
                    .foregroundColor(.mainGreen)
            }
        }
        .padding([.bottom, .trailing, .leading, .top], 0)
        .navigationTitle(character.name)
        .overlay{
            if isLoading {
                LoadingView()
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    @State static var favoriteIds: [Int] = [1]
    static let character = Character(sample: true)
    static var previews: some View {
        CharacterDetailView(character: character, favoriteIds: $favoriteIds)
    }
}
