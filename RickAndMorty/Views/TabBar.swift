//
//  TabBar.swift
//  RickAndMorty
//
//  Created by César Gerace on 29/09/2023.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView{
            CharactersListView().tabItem {
                Image(systemName: "person.2.fill")
                Text("Characters")
            }
            
            LocationsListView().tabItem {
                Image(systemName: "network")
                Text("Locations")
            }
            
            EpisodesListView().tabItem {
                Image(systemName: "text.book.closed.fill")
                Text("Episodes")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
