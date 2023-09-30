//
//  LocationCharacterCell.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 29/09/2023.
//

import SwiftUI
import CachedAsyncImage

struct ResidentCell: View {
    let resident: Character
    
    var body: some View {
            HStack {
                CachedAsyncImage(url: resident.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.scaledToFill()
                    .frame(width: 80 , height: 80)
                    .padding([.leading, .top, .bottom], 0)
                VStack(alignment: . leading) {
                    Text(resident.name)
                        .font(.title3)
                        .bold()
                        .lineLimit(1)
                    Text("Gender: " + resident.gender.rawValue)
                        .multilineTextAlignment(.leading)
                    Text("Status: " + resident.status.rawValue)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 0)
                    
                    Text("")
                }.foregroundColor(.mainBlue)
                Spacer()
                
            }
            
        .padding(.trailing, 10)
        .padding([.leading, .top, .bottom], 0)
        .background(Color.offBlue)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: .offBlue , radius: 8, x:0, y:0)
    }
}

struct LocationCharacterCell_Previews: PreviewProvider {
    static let resident = Character(sample: true)
    static var previews: some View {
        ResidentCell(resident: resident)
    }
}
