//
//  NavigationControllerMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class NavigationControllerMock: UINavigationController {
    enum Message: Equatable {
        case dismiss
    }

    private(set) var receivedMessages = [Message]()

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        receivedMessages.append(.dismiss)
    }
}
