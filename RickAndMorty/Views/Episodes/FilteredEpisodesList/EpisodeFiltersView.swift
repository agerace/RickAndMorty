//
//  EpisodeFiltersView.swift
//  RickAndMorty
//
//  Created by César Gerace on 02/10/2023.
//


import SwiftUI

struct EpisodeFiltersView: View {
    @Binding var filters: EpisodeFilters
    
    var body: some View {
        ZStack {
            Spacer(minLength: UIScreen.main.bounds.height)
                .background(Color.mainGreen.opacity(0.5))
            VStack{
                HStack {
                    Spacer()
                    TextField("Name", text: $filters.name)
                        .frame(width: UIWindow().screen.bounds.width / 2)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Season")
                    Picker("Season", selection: $filters.seasonCode) {
                        ForEach(SeasonCode.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text("Episode")
                    Picker("Episode", selection: $filters.episodeCode) {
                        ForEach(EpisodeCode.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    Spacer()
                }
                
            }
            .foregroundColor(.mainBlue)
                .accentColor(.offBlue)
        }
    }
}

struct EpisodeFiltersView_Previews: PreviewProvider {
    
    @State static var episodeFilters = EpisodeFilters()
    static var previews: some View {
        EpisodeFiltersView(filters: $episodeFilters)
    }
}
