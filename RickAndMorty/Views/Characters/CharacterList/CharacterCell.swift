//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import SwiftUI
import CachedAsyncImage

struct CharacterCell: View {
    private var isFavorite: Bool {
        get {
            favoriteIds.contains(character.id)
        }
    }
    
    let character: Character
    @Binding var favoriteIds: [Int]
    
    var body: some View {
        let favoritesBinding = Binding(get: { favoriteIds }, set: {  newFavoriteIds in
            UserDefaults.standard.favoriteIds = newFavoriteIds
            self.favoriteIds = newFavoriteIds
        })
        NavigationLink(destination: CharacterDetailView(character: character, favoriteIds: favoritesBinding)){
            
            HStack {
                CachedAsyncImage(url: character.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.scaledToFill()
                    .frame(width: 80 , height: 80)
                    .padding([.leading, .top, .bottom], 0)
                VStack(alignment: . leading) {
                    Text(character.name)
                        .font(.title3)
                        .bold()
                        .lineLimit(1)
                    Text(character.gender.rawValue)
                        .multilineTextAlignment(.leading)
                    Text("")
                    Text("More Info")
                        .italic()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 0)
                }
                .foregroundColor(.mainBlue)
            }
        }
        .swipeActions {
            Button(action: {
                if isFavorite {
                    favoriteIds = favoriteIds.filter{$0 != character.id}
                }else {
                    favoriteIds = favoriteIds + [character.id]
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

struct CharacterCell_Previews: PreviewProvider {
    @State static var favoriteIds: [Int] = [1]
    static let character = Character(sample: true)
    static var previews: some View {
        CharacterCell(character: character, favoriteIds: $favoriteIds)
    }
}
