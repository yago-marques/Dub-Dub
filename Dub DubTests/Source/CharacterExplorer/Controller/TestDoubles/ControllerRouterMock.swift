//
//  ControllerRouterMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class ControllerRouterMock: CharactersExplorerRouting {

    enum Message: Equatable {
        case navigateToFilter
    }

    private(set) var receivedMessages = [Message]()

    var navigationController: UINavigationController?

    var mediator: Dub_Dub.ExplorerAndFilterMediation?

    func navigateToFilter() {
        receivedMessages.append(.navigateToFilter)
    }
}
