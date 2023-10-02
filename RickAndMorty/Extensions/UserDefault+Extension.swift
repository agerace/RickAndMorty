//
//  UserDefault+Extension.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import Foundation

extension UserDefaults  {
    var favoriteCharactersIds: [Int] {
        get {
            array(forKey: "favoriteCharactersIds") as? [Int] ?? []
        }
        set {
            set(newValue, forKey: "favoriteCharactersIds")
        }
    }
    var favoriteEpisodesIds: [Int] {
        get {
            array(forKey: "favoriteEpisodesIds") as? [Int] ?? []
        }
        set {
            set(newValue, forKey: "favoriteEpisodesIds")
        }
    }
}
