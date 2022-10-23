//
//  FilterInteractorPresenterMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterInteractorPresenterMock: FilterFormPresenting {
    enum Message: Equatable {
        case updateFilter
        case updateFilterWithNewFilter
    }

    private(set) var receivedMessages = [Message]()

    var controllerDelegate: Dub_Dub.FilterFormInteractorDelegate?

    func updateFilter(with newFilter: Dub_Dub.CharacterFilter) {
        if newFilter.status != nil || newFilter.species != nil || newFilter.genres != nil {
            receivedMessages.append(.updateFilterWithNewFilter)
        } else {
            receivedMessages.append(.updateFilter)
        }

    }
}
