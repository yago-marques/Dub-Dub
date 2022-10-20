//
//  CharacterInfo.swift
//  Dub Dub
//
//  Created by Yago Marques on 19/10/22.
//

import Foundation

enum CharacterInfo {
    static func getStatus() -> [String] {
        ["Alive", "Dead", "unknown"]
    }

    static func getGenres() -> [String] {
        ["Female", "Male", "Genderless", "unknown"]
    }

    static func getSpecies() -> [String] {
        [
            "Human", "Alien", "Humanoid",
            "Animal", "Robot", "Cronenberg",
            "Disease", "Mythological Creature",
            "Poopybutthole", "unknown"
        ]
    }
}
