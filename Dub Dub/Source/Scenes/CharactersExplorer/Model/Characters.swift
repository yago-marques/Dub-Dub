//
//  Characters.swift
//  Dub Dub
//
//  Created by Yago Marques on 18/10/22.
//

import Foundation

struct Characters: Equatable {
    let count: Int
    var next: Int?
    var prev: Int?
    var data: [Character]
}

struct Character: Equatable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: Data
    let imageUrl: String?
    let location: String
}
