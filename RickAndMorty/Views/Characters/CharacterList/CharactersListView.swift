//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import SwiftUI

struct CharactersListView: View {
    @State var favoriteIds: [Int] = UserDefaults.standard.favoriteCharactersIds
    
    @State var errorMessage: String? = nil
    @State var initialLoading = true
    @State var hasMoreCharacters = true
    
    @State var characters = [Character]()
    @State var page = 1
    
    var body: some View {
        
        NavigationView() {
            List(characters) { character in
                let favoritesBinding = Binding(get: { favoriteIds }, set: { newFavoriteIds in
                    UserDefaults.standard.favoriteCharactersIds = newFavoriteIds
                    self.favoriteIds = newFavoriteIds
                })
                CharacterCell(character: character, favoriteIds: favoritesBinding)
                .listRowSeparator(.hidden)
                .onAppear(){
                    if hasMoreCharacters && character == characters[characters.count - 3] {
                        page += 1
                        Task {
                            await loadCharacters(page: page)
                        }
                    }
                }
            }
            .background(Color.offBlue)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .padding(.zero)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FilteredCharactersListView(favoriteIds: $favoriteIds)){
                        Image(systemName: "magnifyingglass").foregroundColor(.mainGreen)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoriteCharactersView(favoriteIds: $favoriteIds)){
                        Image(systemName: "heart.fill").foregroundColor(.mainGreen)
                    }
                }
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
                await loadCharacters()
            }
        }
        
    }
    
    private func loadCharacters(page: Int = 1) async {
        let result = await CharacterRepository().getCharacters(page: page)
        switch result {
        case .success(let newCharacters):
            initialLoading = false
            hasMoreCharacters = newCharacters.count >= 20
            characters.append(contentsOf: newCharacters)
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
