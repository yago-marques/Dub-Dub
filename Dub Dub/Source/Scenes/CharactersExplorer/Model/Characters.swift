//
//  Characters.swift
//  Dub Dub
//
//  Created by Yago Marques on 18/10/22.
//

import Foundation

struct Characters {
    let count: Int
    var next: Int?
    var prev: Int?
    var data: [Character]
}

struct Character {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: String
}
