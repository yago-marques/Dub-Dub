//
//  CharactersExplorerControllerTests.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class CharactersExplorerControllerTests: XCTestCase {

    func test_viewWillAppear_findCharactersPageOne() {
        let (sut, doubles) = makeSUT()

        sut.viewWillAppear(true)

        XCTAssertEqual(doubles.interactorMock.receivedMessages, [.findCharacters(page: 1, filtered: false)])
    }

    func test_loadNextPage_withoutFilter_shouldCallInteractorMethodToLoad() {
        let (sut, doubles) = makeSUT()

        sut.loadNextPage()

        XCTAssertEqual(doubles.interactorMock.receivedMessages, [.loadCharactersNextPage(filtered: false)])
    }

    func test_loadNextPage_withFilter_shouldCallInteractorMethodToLoadFiltered() {
        let (sut, doubles) = makeSUT()
        doubles.presenterStub.activeFilter()

        sut.loadNextPage()

        XCTAssertEqual(doubles.interactorMock.receivedMessages, [.loadCharactersNextPage(filtered: true)])
    }

    func test_showFilter_shouldCallRouterMethodToNavigate() {
        let (sut, doubles) = makeSUT()

        sut.showFilter()

        XCTAssertEqual(doubles.routerMock.receivedMessages, [.navigateToFilter])
    }

    func test_modifyFilter_withNewFilter_shouldFindFilteredCharacters() {
        let (sut, doubles) = makeSUT()

        sut.modifyFilter(with: CharacterFilter(genres: "Female"))

        XCTAssertEqual(doubles.interactorMock.receivedMessages, [.findCharacters(page: 1, filtered: true)])
    }

}

private extension CharactersExplorerControllerTests {
    typealias SutAndDoubles = (
        sut: CharactersExplorerController,
        doubles: (
            interactorMock: ControllerInteractorMock,
            routerMock: ControllerRouterMock,
            presenterStub: ControllerPresenterDelegateStub
        )
    )

    private func makeSUT() -> SutAndDoubles {
        let interactorMock = ControllerInteractorMock()
        let routerMock = ControllerRouterMock()
        let presenterDelegateStub = ControllerPresenterDelegateStub()
        let view = CharactersExplorerView(frame: .zero)
        let sut = CharactersExplorerController(view: view, interactor: interactorMock, presenterDelegate: presenterDelegateStub, router: routerMock)

        return (sut, (interactorMock, routerMock, presenterDelegateStub))
    }
}
