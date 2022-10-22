//
//  InteractorControllerDelegateMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 22/10/22.
//

import XCTest
@testable import Dub_Dub

final class InteractorControllerDelegateMock: CharactersExplorerControllerDelegate {

    enum Message: Equatable {
        case updateCollection
    }

    private(set) var receivedMessages = [Message]()

    func updateCollection() {
        receivedMessages.append(.updateCollection)
    }

}
