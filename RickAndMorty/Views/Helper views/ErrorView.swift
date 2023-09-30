//
//  ErrorView.swift
//  RickAndMorty
//
//  Created by César Gerace on 27/09/2023.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        
        ZStack {
            Image("LoadingImage")
            Spacer(minLength: UIScreen.main.bounds.height)
                .background(.black.opacity(0.8))
            
            Text(errorMessage)
                .foregroundColor(.mainGreen)
        }
        
    }
        
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "This is a sample error")
    }
}
