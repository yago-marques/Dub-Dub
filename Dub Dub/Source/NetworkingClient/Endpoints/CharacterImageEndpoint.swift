//
//  CharacterImageEndpoint.swift
//  Dub Dub
//
//  Created by Yago Marques on 20/10/22.
//

import Foundation

final class CharacterImageEndpoint: EndpointProtocol {
    var urlBase: String = APIConstants.imageBaseUrl.rawValue
    var path: String
    var queries: [URLQueryItem] = []

    init(path: String) {
        self.path = path
    }
}
