//
//  FilterFormControllerTests.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterFormControllerTests: XCTestCase {

    func test_filterItNow_shouldMakeFilterAndbackToExplorer() {
        let (sut, doubles) = makeSUT()

        sut.filterItNow()

        XCTAssertEqual(doubles.interactorMock.receivedMessages, [.makeFilter])
        XCTAssertEqual(doubles.routerMock.receivedMessages, [.backToExplorer])
    }

    func test_updateFilter_shouldCallMediatorToUpdateFilter() {
        let (sut, doubles) = makeSUT()

        sut.updateFilter(with: CharacterFilter())

        XCTAssertEqual(doubles.mediatorMock.receivedMessages, [.modifyFilter])
    }

}

private extension FilterFormControllerTests {
    typealias SutAndDoubles = (
        sut: FilterFormController,
        doubles: (
            interactorMock: FilterControllerInteractorMock,
            routerMock: FilterControllerRouterMock,
            mediatorMock: FilterControllerMediatorMock
        )
    )

    private func makeSUT() -> SutAndDoubles {
        let interactorMock = FilterControllerInteractorMock()
        let routerMock = FilterControllerRouterMock()
        let mediatorMock = FilterControllerMediatorMock()
        let view = FilterFormView(frame: .zero)
        let sut = FilterFormController(view: view, interactor: interactorMock, router: routerMock, navigation: nil, mediator: mediatorMock)

        return (sut, (interactorMock, routerMock, mediatorMock))
    }
}
