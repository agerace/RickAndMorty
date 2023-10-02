//
//  FilteredEpisodesListView.swift
//  RickAndMorty
//
//  Created by César Gerace on 02/10/2023.
//

import SwiftUI

struct FilteredEpisodesListView: View {
    @Binding var favoriteEpisodesIds: [Int]
    
    @State var errorMessage: String? = nil
    @State var showFilters = true
    
    @State var filters = EpisodeFilters()
    @State var episodes = [Episode]()
    @State var page = 1
    @State var hasMoreEpisodes = true
    
    var body: some View {
        ZStack {
            if episodes.count == 0 {
                ErrorView(errorMessage: RMError.emptyListError.rawValue)
            } else {
                List(episodes) { episode in
                    let favoriteBinding = Binding(get: { favoriteEpisodesIds }, set: { newFavoriteIds in
                        UserDefaults.standard.favoriteEpisodesIds = newFavoriteIds
                        self.favoriteEpisodesIds = newFavoriteIds
                    })
                    
                    EpisodeCell(episode: episode, favoriteEpisodesIds: favoriteBinding)
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
            EpisodeFiltersView(filters: $filters)
                .presentationDetents([.fraction(0.3)])
                .onDisappear(){
                    page = 1
                    episodes = []
                    Task {
                        await loadEpisodes(page: page)
                    }
                }
        }
        .accentColor(.mainBlue)
        .foregroundColor(.mainBlue)
        .navigationTitle("Filtered episodes")
    }
    
    private func loadEpisodes(page: Int = 1) async {
        let result = await EpisodesRepository().getFilteredEpisodes(page: page, filters: filters)
        switch result {
        case .success(let newEpisodios):
            episodes.append(contentsOf: newEpisodios)
            hasMoreEpisodes = newEpisodios.count >= 20
        case .failure(let errorMessage):
            self.errorMessage = errorMessage.localizedDescription
            
        }
    }
}

struct FilteredEpisodesListView_Previews: PreviewProvider {
    @State static private var favoriteEpisodesIds = [1,2,3]
    static var previews: some View {
        FilteredEpisodesListView(favoriteEpisodesIds: $favoriteEpisodesIds)
    }
}
