//
//  LocationCell.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 29/09/2023.
//

import SwiftUI

struct LocationCell: View {
    
    let location: Location
    
    var body: some View {
        NavigationLink(destination: LocationDetailView(location: location)){
                VStack(alignment: . leading) {
                    Text(location.name)
                        .font(.title3)
                        .bold()
                        .lineLimit(1)
                    Text(location.dimension)
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
        .padding(.trailing, 10)
        .padding([.leading, .top, .bottom], 0)
        .background(Color.offBlue)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color:.offBlue, radius: 8, x:0, y:0)
    }
}

struct LocationCell_Previews: PreviewProvider {
    static let location = Location(name:"Sample location", dimension: "Sample dimension")
    static var previews: some View {
        LocationCell(location: location)
    }
}
