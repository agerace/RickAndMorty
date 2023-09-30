//
//  FavoriteCharactersView.swift
//  RickAndMorty
//
//  Created by César Gerace on 29/09/2023.
//

import SwiftUI

struct FavoriteCharactersView: View {
    @Binding var favoriteIds: [Int]
    
    @State var errorMessage: String? = nil
    @State var initialLoading = true
    
    @State var characters = [Character]()
    
    var body: some View {
        
        List(characters) { character in
            let favoriteBinding = Binding(get: { favoriteIds }, set: { newFavoriteIds in
                UserDefaults.standard.favoriteIds = newFavoriteIds
                self.favoriteIds = newFavoriteIds
            })
            CharacterCell(character: character, favoriteIds: favoriteBinding)
            .listRowSeparator(.hidden)
        }
        .background(.black)
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .padding(.zero)
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
        .navigationTitle("Favorites")
        .onAppear{
            Task {
                await loadFavoriteCharacters()
            }
        }
        
    }
    
    private func loadFavoriteCharacters() async {
        let result = await CharacterRepository().getCharacters(ids: favoriteIds)
        switch result {
        case .success(let newCharacters):
            initialLoading = false
            characters = newCharacters
            if newCharacters.isEmpty {
                self.errorMessage = RMError.emptyListError.rawValue
            }
        case .failure(let error):
            self.errorMessage = error.rawValue
        }
    }
}


struct FavoriteCharactersView_Previews: PreviewProvider {
    @State static private var favoriteIds = [1,2,3]
    static var previews: some View {
        FavoriteCharactersView(favoriteIds: $favoriteIds)
    }
}
