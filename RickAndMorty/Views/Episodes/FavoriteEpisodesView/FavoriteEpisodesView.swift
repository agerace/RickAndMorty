//
//  FavoriteEpisodesView.swift
//  RickAndMorty
//
//  Created by César Gerace on 02/10/2023.
//

import SwiftUI

struct FavoriteEpisodesView: View {
    @Binding var favoriteEpisodesIds: [Int]
    
    @State var errorMessage: String? = nil
    @State var initialLoading = true
    
    @State var episodes = [Episode]()
    
    var body: some View {
        
        List(episodes) { episode in
            let favoriteBinding = Binding(get: { favoriteEpisodesIds }, set: { newFavoriteIds in
                UserDefaults.standard.favoriteEpisodesIds = newFavoriteIds
                self.favoriteEpisodesIds = newFavoriteIds
            })
            EpisodeCell(episode: episode, favoriteEpisodesIds: favoriteBinding)
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
                await loadFavoriteEpisodes()
            }
        }
        
    }
    
    private func loadFavoriteEpisodes() async {
        let result = await EpisodesRepository().getEpisodes(ids: favoriteEpisodesIds)
        switch result {
        case .success(let newEpisodes):
            initialLoading = false
            episodes = newEpisodes
            if newEpisodes.isEmpty {
                self.errorMessage = RMError.emptyListError.rawValue
            }
        case .failure(let error):
            self.errorMessage = error.rawValue
        }
    }
}


struct FavoriteEpisodesView_Previews: PreviewProvider {
    @State static private var favoriteIds = [1,2,3]
    static var previews: some View {
        FavoriteEpisodesView(favoriteEpisodesIds: $favoriteIds)
    }
}
