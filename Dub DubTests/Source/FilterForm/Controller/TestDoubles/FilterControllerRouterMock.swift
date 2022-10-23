//
//  FilterControllerRouterMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterControllerRouterMock: FilterFormRouting {
    enum Message: Equatable {
        case backToExplorer
    }

    private(set) var receivedMessages = [Message]()

    var navigationController: UINavigationController?

    func backToExplorer() {
        receivedMessages.append(.backToExplorer)
    }
}
