//
//  CharactersExplorerRouterTests.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class CharactersExplorerRouterTests: XCTestCase {

    func test_navigateToFilter_shouldCallFactoryAndMakeView() {
        let (sut, doubles) = makeSUT()

        sut.navigateToFilter()

        XCTAssertEqual(doubles.factoryMock.receivedMessages, [.make])
        XCTAssertEqual(doubles.navigationMock.receivedMessages, [.present])
    }

}

private extension CharactersExplorerRouterTests {
    typealias SutAndDoubles = (
        sut: CharactersExplorerRouter,
        doubles: (
            factoryMock: RouterFactorySpy,
            navigationMock: RouterNavigationMock
        )
    )

    private func makeSUT() -> SutAndDoubles {
        let factoryMock = RouterFactorySpy()
        let mediator = RouterMediatorMock()
        let navigationMock = RouterNavigationMock()
        let sut = CharactersExplorerRouter(
            navigationController: navigationMock,
            mediator: mediator,
            factory: factoryMock
        )

        return (sut, (factoryMock, navigationMock))
    }
}
