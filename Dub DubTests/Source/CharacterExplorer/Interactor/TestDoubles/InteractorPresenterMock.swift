//
//  InteractorPresenterMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 22/10/22.
//

import XCTest
@testable import Dub_Dub

final class InteractorPresenterMock: CharacterExplorerPresenting {

    enum Message: Equatable {
        case loadCharacters(page: Int)
        case updateCharacters(page: Int)
        case loadCharactersWithCache
    }

    var characters: Dub_Dub.Characters = .init(count: 1, next: 2, data: [Dub_Dub.Character(name: "", status: "", species: "", gender: "", image: Data(), imageUrl: "", location: "")])

    var interactorDelegate: Dub_Dub.CharactersExplorerInteractorDelegate?

    private(set) var receivedMessages = [Message]()

    init(interactorDelegate: Dub_Dub.CharactersExplorerInteractorDelegate? = nil) {
        self.interactorDelegate = interactorDelegate
    }

    func loadCharacters(with characters: Dub_Dub.Characters) {
        if let next = characters.next {
            receivedMessages.append(.loadCharacters(page: next - 1))
        } else {
            receivedMessages.append(.loadCharactersWithCache)
        }

        interactorDelegate?.updateCollection()
    }

    func updateCharacters(with characters: Dub_Dub.Characters) {
        if let next = characters.next {
            receivedMessages.append(.updateCharacters(page: next - 1))
            interactorDelegate?.updateCollection()
        }
    }
}

extension InteractorPresenterMock {
    func turnNextPageNil() {
        self.characters.next = nil
    }
}
