//
//  CharacterExplorerInteractorTests.swift
//  Dub DubTests
//
//  Created by Yago Marques on 22/10/22.
//

import XCTest
@testable import Dub_Dub

final class CharacterExplorerInteractorTests: XCTestCase {

    func test_findCharacters_withPageOne_WhenCoreDataIsEmpty_shouldLoadCharactersAndCreateCache() {
        let (sut, doubles) = makeSUT()

        sut.findCharacters(page: 1, genres: nil, status: nil, species: nil)

        XCTAssertEqual(doubles.networkingSpy.receivedMessages, [.charactersReturned])
        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.loadCharacters(page: 1)])
        XCTAssertEqual(doubles.coreDataStub.receivedMessages, [.get, .post])
        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [.updateCollection])
    }

    func test_findCharacters_withPageOne_WhenCoreDataIsNotEmpty_shouldLoadCharacters() {
        let (sut, doubles) = makeSUT()
        doubles.coreDataStub.populate()

        sut.findCharacters(page: 1, genres: nil, status: nil, species: nil)

        XCTAssertEqual(doubles.networkingSpy.receivedMessages, [.charactersReturned])
        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.loadCharacters(page: 1)])
        XCTAssertEqual(doubles.coreDataStub.receivedMessages, [.get])
        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [.updateCollection])
    }

    func test_findCharacters_whenInternetIsOff_WhenCoreDataIsNotEmpty_shouldLoadCharactersCache() {
        let (sut, doubles) = makeSUT()
        doubles.coreDataStub.populate()
        doubles.networkingSpy.connectionIsOn = false

        sut.findCharacters(page: 1, genres: nil, status: nil, species: nil)

        XCTAssertEqual(doubles.networkingSpy.receivedMessages, [.errorReturned])
        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.loadCharactersWithCache])
        XCTAssertEqual(doubles.coreDataStub.receivedMessages, [.get, .get])
        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [.updateCollection])
    }

    func test_findCharacters_whenInternetIsOff_WhenCoreDataIsEmpty_shouldNotLoadCharactersCache() {
        let (sut, doubles) = makeSUT()
        doubles.coreDataStub.turnCharactersNil()
        doubles.networkingSpy.connectionIsOn = false

        sut.findCharacters(page: 1, genres: nil, status: nil, species: nil)

        XCTAssertEqual(doubles.networkingSpy.receivedMessages, [.errorReturned])
        XCTAssertEqual(doubles.presenterMock.receivedMessages, [])
        XCTAssertEqual(doubles.coreDataStub.receivedMessages, [.get])
        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [])
    }

    func test_findCharacters_withSomeFilter_filteredCharactersReturned() {
        let (sut, doubles) = makeSUT()

        sut.findCharacters(page: 1, genres: "Male", status: "", species: "")

        XCTAssertEqual(doubles.networkingSpy.receivedMessages, [.filteredCharactersReturned])
        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.loadCharacters(page: 1)])
        XCTAssertEqual(doubles.coreDataStub.receivedMessages, [.get, .post])
        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [.updateCollection])
    }

    func test_loadCharactersNextPage_withTwoPages_loadCharactersAndUpdateCharacters() {
        let (sut, doubles) = makeSUT()

        sut.findCharacters(page: 1, genres: nil, status: nil, species: nil)
        sut.loadCharactersNextPage(genres: nil, status: nil, species: nil)

        XCTAssertEqual(doubles.networkingSpy.receivedMessages, [.charactersReturned, .charactersReturned])
        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.loadCharacters(page: 1), .updateCharacters(page: 2)])
        XCTAssertEqual(doubles.coreDataStub.receivedMessages, [.get, .post])
        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [.updateCollection, .updateCollection])
    }

    func test_loadCharactersNextPage_withSomeFilter_filteredCharactersReturned() {
        let (sut, doubles) = makeSUT()

        sut.findCharacters(page: 1, genres: nil, status: nil, species: nil)
        sut.findCharacters(page: 1, genres: nil, status: nil, species: "Human")

        XCTAssertEqual(doubles.networkingSpy.receivedMessages, [.charactersReturned, .filteredCharactersReturned])
        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.loadCharacters(page: 1), .loadCharacters(page: 1)])
        XCTAssertEqual(doubles.coreDataStub.receivedMessages, [.get, .post, .get])
        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [.updateCollection, .updateCollection])
    }

    func test_loadCharactersNextPage_withInvalidNextPage_canNotFindCharacters() {
        let (sut, doubles) = makeSUT()

        sut.findCharacters(page: 1, genres: nil, status: nil, species: nil)
        doubles.presenterMock.turnNextPageNil()
        sut.loadCharactersNextPage(genres: nil, status: nil, species: nil)

        XCTAssertEqual(doubles.networkingSpy.receivedMessages, [.charactersReturned])
        XCTAssertEqual(doubles.presenterMock.receivedMessages, [.loadCharacters(page: 1)])
        XCTAssertEqual(doubles.coreDataStub.receivedMessages, [.get, .post])
        XCTAssertEqual(doubles.controllerDelegateMock.receivedMessages, [.updateCollection])
    }

}

private extension CharacterExplorerInteractorTests {
    typealias SutAndDoubles = (
        sut: CharactersExplorerInteractor,
        doubles: (
            networkingSpy: InteractorNetworkingWorkerSpy,
            coreDataStub: InteractorCoreDataWorkerStub,
            presenterMock: InteractorPresenterMock,
            controllerDelegateMock: InteractorControllerDelegateMock
        )
    )

    private func makeSUT() -> SutAndDoubles {
        let networkingSpy = InteractorNetworkingWorkerSpy()
        let coreDataStub = InteractorCoreDataWorkerStub()
        let presenterMock = InteractorPresenterMock()
        let controllerDelegateMock = InteractorControllerDelegateMock()
        let sut = CharactersExplorerInteractor(networkingWorker: networkingSpy, presenter: presenterMock, coreDataWorker: coreDataStub)
        sut.controllerDelegate = controllerDelegateMock
        presenterMock.interactorDelegate = sut

        return (sut, (networkingSpy, coreDataStub, presenterMock, controllerDelegateMock))
    }
}
