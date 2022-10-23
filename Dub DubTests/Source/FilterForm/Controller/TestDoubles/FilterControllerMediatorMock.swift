//
//  FilterControllerMediatorMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterControllerMediatorMock: ExplorerAndFilterMediation {
    enum Message: Equatable {
        case modifyFilter
    }

    private(set) var receivedMessages = [Message]()

    func modifyFilter(with newFilter: Dub_Dub.CharacterFilter) {
        receivedMessages.append(.modifyFilter)
    }
}
