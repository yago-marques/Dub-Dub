//
//  CharacterInteractorMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class ControllerInteractorMock: CharactersExplorerInteracting {

    enum Message: Equatable {
        case findCharacters(page: Int, filtered: Bool)
        case loadCharactersNextPage(filtered: Bool)
    }

    private(set) var receivedMessages = [Message]()

    var controllerDelegate: Dub_Dub.CharactersExplorerControllerDelegate?

    func findCharacters(page: Int, genres: String?, status: String?, species: String?) {
        if genres != nil || status != nil || species != nil {
            receivedMessages.append(.findCharacters(page: page, filtered: true))
        } else {
            receivedMessages.append(.findCharacters(page: page, filtered: false))
        }
    }

    func loadCharactersNextPage(genres: String?, status: String?, species: String?) {
        if genres != nil || status != nil || species != nil {
            receivedMessages.append(.loadCharactersNextPage(filtered: true))
        } else {
            receivedMessages.append(.loadCharactersNextPage(filtered: false))
        }
    }
}
