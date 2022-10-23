//
//  FilterFormRouterTests.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterFormRouterTests: XCTestCase {

    func test_backToExplorer_shouldCallDismissMethodOnNavigationController() {
        let (sut, double) = makeSUT()

        sut.backToExplorer()

        XCTAssertEqual(double.receivedMessages, [.dismiss])
    }

}

private extension FilterFormRouterTests {
    typealias SutAndDoubles = (
        sut: FilterFormRouter,
        double: NavigationControllerMock
    )

    private func makeSUT() -> SutAndDoubles {
        let double = NavigationControllerMock()
        let sut = FilterFormRouter(navigationController: double)

        return (sut, double)
    }
}
