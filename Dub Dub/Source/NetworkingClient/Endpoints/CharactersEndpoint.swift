//
//  CharactersEndpoint.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import Foundation

final class CharactersEndpoint: EndpointProtocol {
    var urlBase: String = APIConstants.baseUrl.rawValue
    var path: String = APIConstants.Paths.characters.rawValue
    var queries: [URLQueryItem] = []

    init(page: Int, species: String? = nil, genres: String? = nil, status: String? = nil) {
        self.queries = [.init(name: "page", value: String(page))]

        if let species {
            self.queries.append(.init(name: "species", value: species))
        }

        if let genres {
            self.queries.append(.init(name: "gender", value: genres))
        }

        if let status {
            self.queries.append(.init(name: "status", value: status))
        }
    }
}
