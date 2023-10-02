//
//  EpisodesListView.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 02/10/2023.
//

import SwiftUI

struct EpisodesListView: View {
    @State var favoriteEpisodeIds: [Int] = UserDefaults.standard.favoriteEpisodesIds
    
    @State var errorMessage: String? = nil
    @State var initialLoading = true
    @State var hasMoreEpisodes = true
    
    @State var episodes = [Episode]()
    @State var page = 1
    
    var body: some View {
        
        NavigationView() {
            let favoritesBinding = Binding(get: { favoriteEpisodeIds }, set: { newFavoriteIds in
                UserDefaults.standard.favoriteEpisodesIds = newFavoriteIds
                self.favoriteEpisodeIds = newFavoriteIds
            })
            
            List(episodes) { episode in
                EpisodeCell(episode: episode, favoriteEpisodesIds: favoritesBinding)
                .listRowSeparator(.hidden)
                .onAppear(){
                    if hasMoreEpisodes && episode == episodes[episodes.count - 3] {
                        page += 1
                        Task {
                            await loadEpisodes(page: page)
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
                    NavigationLink(destination: FilteredEpisodesListView(favoriteEpisodesIds: $favoriteEpisodeIds)){
                        Image(systemName: "magnifyingglass").foregroundColor(.mainGreen)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoriteEpisodesView(favoriteEpisodesIds: $favoriteEpisodeIds)){
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
                await loadEpisodes()
            }
        }
        
    }
    
    private func loadEpisodes(page: Int = 1) async {
        let result = await EpisodesRepository().getEpisodes(page: page)
        switch result {
        case .success(let newEpisodes):
            initialLoading = false
            hasMoreEpisodes = newEpisodes.count >= 20
            episodes.append(contentsOf: newEpisodes)
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}

struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView()
    }
}
