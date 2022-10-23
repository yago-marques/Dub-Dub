//
//  FilterInteractorControllerDelegateMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterInteractorControllerDelegateMock: FilterFormControllerDelegate {

    enum Message: Equatable {
        case updateFilter
    }

    private(set) var receivedMessages = [Message]()

    func updateFilter(with newFilter: Dub_Dub.CharacterFilter) {
        receivedMessages.append(.updateFilter)
    }
}
