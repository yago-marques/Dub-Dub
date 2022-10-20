//
//  APICharacters.swift
//  Dub Dub
//
//  Created by Yago Marques on 18/10/22.
//

import Foundation

struct APICharacters: Codable {
    let info: PaginationResponse
    let results: [CharacterResponse]
}
