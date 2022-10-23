//
//  FilterControllerInteractorMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterControllerInteractorMock: FilterFormInteracting {
    enum Message: Equatable {
        case makeFilter
    }

    private(set) var receivedMessages = [Message]()

    var controllerDelegate: Dub_Dub.FilterFormControllerDelegate?

    func makeFilter(with filter: Dub_Dub.CharacterFilter) {
        receivedMessages.append(.makeFilter)
    }
}
