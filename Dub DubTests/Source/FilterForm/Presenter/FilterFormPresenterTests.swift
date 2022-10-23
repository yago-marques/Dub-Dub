//
//  FilterFormPresenterTestes.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterFormPresenterTests: XCTestCase {

    func test_updateFilter_shouldCallControllerDelegate() {
        let (sut, double) = makeSUT()

        sut.updateFilter(with: CharacterFilter())

        XCTAssertEqual(double.receivedMessages, [.updateFilter])
    }

}

private extension FilterFormPresenterTests {
    typealias SutAndDoubles = (
        sut: FilterFormPresenter,
        double: FilterPresentercontrollerDelegateMock
    )

    private func makeSUT() -> SutAndDoubles {
        let double = FilterPresentercontrollerDelegateMock()
        let sut = FilterFormPresenter(controllerDelegate: double)

        return (sut, double)
    }
}
