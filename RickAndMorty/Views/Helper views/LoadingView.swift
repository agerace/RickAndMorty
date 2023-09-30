//
//  LoadingView.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Spacer(minLength: UIScreen.main.bounds.height)
                .background(.black.opacity(0.8))
            Image("LoadingImage")
            ProgressView()
                .scaleEffect(3)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
