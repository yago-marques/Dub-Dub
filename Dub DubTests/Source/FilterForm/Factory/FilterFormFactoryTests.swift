//
//  FilterFormFactoryTests.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class FilterFormFactoryTests: XCTestCase {

    func test_make_makeValidFilterForm() {
        let sut = makeSUT()

        let newController = sut.make(navigation: UINavigationController(), mediator: RouterMediatorMock())

        XCTAssertNotNil(newController)
    }

}

private extension FilterFormFactoryTests {
    private func makeSUT() -> FilterFormFactory {
        FilterFormFactory()
    }
}
