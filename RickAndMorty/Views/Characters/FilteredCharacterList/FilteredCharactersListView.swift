//
//  FilteredCharactersListView.swift
//  RickAndMorty
//
//  Created by César Gerace on 28/09/2023.
//

import SwiftUI

struct FilteredCharactersListView: View {
    @Binding var favoriteIds: [Int]
    
    @State var errorMessage: String? = nil
    @State var showFilters = true
    
    @State var filters = Filters()
    @State var characters = [Character]()
    @State var page = 1
    @State var hasMoreCharacters = true
    
    var body: some View {
        ZStack {
            if characters.count == 0 {
                ErrorView(errorMessage: RMError.emptyListError.rawValue)
            } else {
                List(characters) { character in
                    let favoriteBinding = Binding(get: { favoriteIds }, set: { newFavoriteIds in
                        UserDefaults.standard.favoriteIds = newFavoriteIds
                        self.favoriteIds = newFavoriteIds
                    })
                    CharacterCell(character: character, favoriteIds: favoriteBinding)
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
                .background(.black)
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .padding(.zero)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showFilters = true }) {
                    Image(systemName: "slider.horizontal.3").foregroundColor(.mainGreen)
                }
                
            }
            
        }
        .sheet(isPresented: $showFilters){
            FiltersView(filters: $filters)
                .presentationDetents([.fraction(0.3)])
                .onDisappear(){
                    page = 1
                    characters = []
                    Task {
                        await loadCharacters(page: page)
                    }
                }
        }
        .accentColor(.mainBlue)
        .foregroundColor(.mainBlue)
        .navigationTitle("Filtered characters")
    }
    
    private func loadCharacters(page: Int = 1) async {
        let result = await CharacterRepository().getFilteredCharacters(page: page, filters: filters)
        switch result {
        case .success(let newCharacters):
            characters.append(contentsOf: newCharacters)
            hasMoreCharacters = newCharacters.count >= 20
        case .failure(let errorMessage):
            self.errorMessage = errorMessage.localizedDescription
            
        }
    }
}

struct FilteredCharactersListView_Previews: PreviewProvider {
    @State static private var favoriteIds = [1,2,3]
    static var previews: some View {
        FilteredCharactersListView(favoriteIds: $favoriteIds)
    }
}
