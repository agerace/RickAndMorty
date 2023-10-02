//
//  EpisodeCell.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 02/10/2023.
//

import SwiftUI

struct EpisodeCell: View {
    private var isFavorite: Bool {
        get {
            favoriteEpisodesIds.contains(episode.id)
        }
    }
    
    let episode: Episode
    @Binding var favoriteEpisodesIds: [Int]
    
    var body: some View {
        let favoritesBinding = Binding(get: { favoriteEpisodesIds }, set: {  newFavoriteIds in
            UserDefaults.standard.favoriteEpisodesIds = newFavoriteIds
            self.favoriteEpisodesIds = newFavoriteIds
        })
        NavigationLink(destination: EpisodeDetailView(episode: episode, favoriteEpisodesIds: favoritesBinding)){
                VStack(alignment: . leading) {
                    Text(episode.name)
                        .font(.title3)
                        .bold()
                        .lineLimit(1)
                    Text(episode.episodeCode)
                        .multilineTextAlignment(.leading)
                    Text("")
                    Text("More Info")
                        .italic()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 0)
                }
                .padding(.leading, 8)
                .padding([.top, .bottom], 2)
                .foregroundColor(.mainBlue)
        }
        .swipeActions {
            Button(action: {
                if isFavorite {
                    favoriteEpisodesIds = favoriteEpisodesIds.filter{$0 != episode.id}
                }else {
                    favoriteEpisodesIds = favoriteEpisodesIds + [episode.id]
                }
            }){Image(systemName: isFavorite ? "heart.fill" : "heart")}
                .tint(isFavorite ? .mainBlue : .mainGreen)
        }
        .padding(.trailing, 10)
        .padding([.leading, .top, .bottom], 0)
        .background(Color.offBlue)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: isFavorite ? .mainGreen : .mainBlue , radius: 8, x:0, y:0)
    }
}

struct EpisodeCell_Previews: PreviewProvider {
    @State static var favoriteEpisodesIds: [Int] = [1]
    static let episode = Episode(sample: true)
    static var previews: some View {
        EpisodeCell(episode: episode, favoriteEpisodesIds: $favoriteEpisodesIds)
    }
}
