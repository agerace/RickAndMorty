//
//  EpisodeDetailView.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 02/10/2023.
//

import SwiftUI
import CachedAsyncImage

struct EpisodeDetailView: View {
    @State var errorMessage: String?
    
    @State var isLoading = true
    
    @State var characters: [Character] = []
    @State var episode: Episode? = nil
    @State var episodeId: Int? = nil
    
    @Binding var favoriteEpisodesIds: [Int]
    
    private var isFavorite: Bool {
        get {
            if let episode = episode {
                return favoriteEpisodesIds.contains(episode.id)
            }else if let episodeId = episodeId {
                return favoriteEpisodesIds.contains(episodeId)
            }else {
                return false
            }
        }
    }
    
    var body: some View {
        
        VStack {
            if let episode = episode {
                VStack {
                    Text("Name: " + episode.name)
                    Text("Code: " + episode.episodeCode)
                    Text("Air date: " + episode.airDate)
                    Divider()
                    Text("CHARACTERS")
                        .bold()
                        .font(.title)
                }
                .background(Color.offBlue)
                .foregroundColor(.mainGreen)
            }
            List(characters) { character in
                ResidentCell(resident: character)
                    .listRowSeparator(.hidden)
            }
            .background(Color.offBlue)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .padding(.zero)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if isFavorite {
                        favoriteEpisodesIds = favoriteEpisodesIds.filter{$0 != episode!.id}
                    }else {
                        favoriteEpisodesIds = favoriteEpisodesIds + [episode!.id]
                    }
                })
                {Image(systemName: isFavorite ? "heart.fill" : "heart")}
                    .foregroundColor(.mainGreen)
            }
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
        .navigationTitle("Episode")
        .onAppear {
            Task {
                if let episode = episode {
                    await loadCharacters(ids: episode.charactersIds)
                }else if let episodeId = episodeId {
                    await loadEpisodeWith(id: episodeId)
                }else {
                    
                }
            }
        }
    }
    
    private func loadEpisodeWith(id: Int) async {
        self.isLoading = true
        let result = await EpisodesRepository().getEpisodeWith(id: id)
        switch result {
        case .success(let episode):
            self.episode = episode
            self.isLoading = false
            await loadCharacters(ids: episode.charactersIds)
        case .failure(let error):
            errorMessage = error.rawValue
        }
    }
    
    private func loadCharacters(ids: [Int]) async {
        let result = await CharacterRepository().getCharacters(ids: ids)
        switch result {
        case .success(let newCharacters):
            self.isLoading = false
            characters = newCharacters
        case .failure(let error):
            self.errorMessage = error.rawValue
        }
    }
    
}

struct EpisodeDetailView_Previews: PreviewProvider {
    @State static var favoriteEpisodesId = [1,2,3]
    static var previews: some View {
        EpisodeDetailView(episodeId:1, favoriteEpisodesIds: $favoriteEpisodesId)
    }
}
