//
//  PaginationResponse.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import Foundation

struct PaginationResponse: Codable {
    let count: Int
    let next: String?
    let prev: String?
}
