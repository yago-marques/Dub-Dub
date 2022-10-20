//
//  CharacterResponse.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import Foundation

struct CharacterResponse: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: LocationResponse

    struct LocationResponse: Codable {
        let name: String
    }
}
