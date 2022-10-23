//
//  RouterNavigationMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class RouterNavigationMock: UINavigationController {
    enum Message: Equatable {
        case present
    }

    private(set) var receivedMessages = [Message]()

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        receivedMessages.append(.present)
    }
}
