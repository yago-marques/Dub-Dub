//
//  CharactersConstants.swift
//  Dub DubTests
//
//  Created by Yago Marques on 22/10/22.
//

import Foundation
@testable import Dub_Dub

struct CharactersConstants {
    static func getCharacters() -> Characters {
        Characters(count: 1, next: 2, data: [self.getCharacter()])
    }

    static func getCharacter(name: String = "") -> Character {
        Dub_Dub.Character(name: name, status: "", species: "", gender: "", image: Data(), imageUrl: "", location: "")
    }
}
