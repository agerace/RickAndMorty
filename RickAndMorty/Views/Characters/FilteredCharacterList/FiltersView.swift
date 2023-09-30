//
//  FiltersView.swift
//  RickAndMorty
//
//  Created by César Gerace on 28/09/2023.
//


import SwiftUI
struct FiltersView: View {
    @Binding var filters: Filters
    
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
                    TextField("Type", text: $filters.type)
                        .frame(width: UIWindow().screen.bounds.width / 2)
                    Spacer()
                }
                HStack {
                    Spacer()
                    TextField("Species", text: $filters.species)
                        .frame(width: UIWindow().screen.bounds.width / 2)
                    Spacer()
                }
                HStack {
                    Spacer()
                    
                    Text("Gender")
                    Picker("Gender", selection: $filters.gender) {
                        ForEach(CharacterGender.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    Spacer()
                }
                HStack {
                    Text("Status")
                    Picker("Status", selection: $filters.status) {
                        ForEach(CharacterStatus.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            }
            .foregroundColor(.mainBlue)
                .accentColor(.offBlue)
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    
    @State static var filters = Filters()
    static var previews: some View {
        FiltersView(filters: $filters)
    }
}
