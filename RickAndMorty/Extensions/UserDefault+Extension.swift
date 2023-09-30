//
//  UserDefault+Extension.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import Foundation

extension UserDefaults  {
    var favoriteIds: [Int] {
        get {
            array(forKey: "favoriteIds") as? [Int] ?? []
        }
        set {
            set(newValue, forKey: "favoriteIds")
        }
    }
}
