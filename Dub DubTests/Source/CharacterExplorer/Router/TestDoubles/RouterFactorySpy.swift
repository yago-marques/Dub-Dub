//
//  RouterFactoryMock.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class RouterFactorySpy: FilterFormFactoring {
    enum Message: Equatable {
        case make
    }

    private(set) var receivedMessages = [Message]()

    func make(navigation: UINavigationController, mediator: Dub_Dub.ExplorerAndFilterMediation) -> UIViewController {
        receivedMessages.append(.make)

        return UIViewController()
    }
}
