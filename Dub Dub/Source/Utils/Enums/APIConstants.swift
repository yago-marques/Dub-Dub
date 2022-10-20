//
//  APIRoutes.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import Foundation

enum APIConstants: String {
    case baseUrl = "https://rickandmortyapi.com/api"

    enum Numbers: Int {
        case pageUrlCountWithoutPageNumber = 47
    }

    enum Paths: String {
        case characters = "/character"
        case locations = "/location"
        case episodes = "/episode"
    }
}
