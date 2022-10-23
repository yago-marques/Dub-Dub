//
//  FilterFormInteractor.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterFormInteractorTests: XCTestCase {

    func test_makeFilter_whenAllFiltersAreNil_shouldCallPresenterToUpdateFilter() {
        let (sut, doubles) = makeSUT()

        sut.makeFilter(with: CharacterFilter())

        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.updateFilter])
    }

    func test_makeFilter_whenAllFiltersAreValid_shouldCallPresenterToUpdateNewFilter() {
        let (sut, doubles) = makeSUT()

        sut.makeFilter(with: CharacterFilter(genres: "Male", status: "Alive", species: "Alien"))

        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.updateFilterWithNewFilter])
    }

    func test_updateFilter_shouldCallControllerDelegateToUpdateOnController() {
        let (sut, doubles) = makeSUT()

        sut.updateFilter(with: CharacterFilter())

        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [.updateFilter])
    }

}

private extension FilterFormInteractorTests {
    typealias SutAndDoubles = (
        sut: FilterFormInteractor,
        doubles: (
            presenterMock: FilterInteractorPresenterMock,
            controllerDelegateMock: FilterInteractorControllerDelegateMock
        )
    )

    private func makeSUT() -> SutAndDoubles {
        let presenterMock = FilterInteractorPresenterMock()
        let controllerDelegateMock = FilterInteractorControllerDelegateMock()
        let sut = FilterFormInteractor( controllerDelegate: controllerDelegateMock, presenter: presenterMock)

        return (sut, (presenterMock, controllerDelegateMock))
    }
}
