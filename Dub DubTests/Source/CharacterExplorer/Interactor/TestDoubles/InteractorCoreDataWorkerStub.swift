//
//  InteractorCoreDataWorkerStub.swift
//  Dub DubTests
//
//  Created by Yago Marques on 22/10/22.
//

import XCTest
@testable import Dub_Dub

final class InteractorCoreDataWorkerStub: CharacterCoreDataWorking {

    enum Message: Equatable {
        case get
        case post
    }

    private var characters: [Dub_Dub.Character?]? = []
    private(set) var receivedMessages = [Message]()

    func get() -> [Dub_Dub.Character?]? {
        receivedMessages.append(.get)
        return self.characters
    }

    func post(with character: Dub_Dub.Character) {
        self.characters?.append(character)
        receivedMessages.append(.post)
    }

    func populate() {
        characters = [
            Dub_Dub.Character(name: "", status: "", species: "", gender: "", image: Data(), imageUrl: "", location: "")
        ]
    }

    func turnCharactersNil() {
        self.characters = nil
    }
}
