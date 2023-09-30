//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by César Gerace on 26/09/2023.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
    }
    
    init() {
        setNavigationViewAppearance()
        setTabViewAppearance()
    }
    
    private func setNavigationViewAppearance() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(.offBlue)
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(.mainBlue)]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(.mainBlue)]
        coloredAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.mainBlue)]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    private func setTabViewAppearance() {
        let coloredAppearance = UITabBarAppearance()
        coloredAppearance.backgroundColor = UIColor(Color.offBlue)
        coloredAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(.mainBlue)]
        coloredAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(.mainGreen)]
        coloredAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(.mainBlue)
        coloredAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(.mainGreen)
        
        UITabBar.appearance().standardAppearance = coloredAppearance
        UITabBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
}
