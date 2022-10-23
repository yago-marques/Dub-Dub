//
//  CharacterExplorerPresenterTests.swift
//  Dub DubTests
//
//  Created by Yago Marques on 22/10/22.
//

import XCTest
@testable import Dub_Dub

final class CharacterExplorerPresenterTests: XCTestCase {

    func test_loadCharacters_withValidCharacters_updateCharactersCollection() {
        let (sut, double) = makeSUT()
        let characters = CharactersConstants.getCharacters()

        sut.loadCharacters(with: characters)

        XCTAssertEqual(double.receivedMessages, [.updateCollection])
    }

    func test_updateCharacters_updatePrevAndNextPage() {
        let (sut, double) = makeSUT()
        var characters = CharactersConstants.getCharacters()
        characters.data = [CharactersConstants.getCharacter(name: "name1")]

        sut.updateCharacters(with: characters)

        XCTAssertEqual(sut.characters.next, characters.next)
        XCTAssertEqual(sut.characters.prev, characters.prev)
        XCTAssertEqual(sut.characters.data.last, characters.data.last)
        XCTAssertEqual(double.receivedMessages, [.updateCollection, .updateCollection, .updateCollection])
    }

    func test_updateCharacters_withTwoDifferentsCharacterModel_callUpdateCollectionFourTimes() {
        let (sut, double) = makeSUT()
        var characters = CharactersConstants.getCharacters()
        characters.data = [
            CharactersConstants.getCharacter(name: "name1"),
            CharactersConstants.getCharacter(name: "name2")
        ]

        sut.updateCharacters(with: characters)

        XCTAssertEqual(double.receivedMessages, [.updateCollection, .updateCollection, .updateCollection, .updateCollection])
    }

    func test_updateCharacters_withTwoEqualsCharacterModel_callUpdateCollectionTheeTimes() {
        let (sut, double) = makeSUT()
        var characters = CharactersConstants.getCharacters()
        characters.data = [
            CharactersConstants.getCharacter(name: "name1"),
            CharactersConstants.getCharacter(name: "name1")
        ]

        sut.updateCharacters(with: characters)

        XCTAssertEqual(double.receivedMessages, [.updateCollection, .updateCollection, .updateCollection])
    }

}

private extension CharacterExplorerPresenterTests {
    typealias SutAndDoubles = (
        sut: CharacterExplorerPresenter,
        double: PresenterInteractorDelegateMock
    )

    private func makeSUT() -> SutAndDoubles {
        let double = PresenterInteractorDelegateMock()
        let sut = CharacterExplorerPresenter(interactorDelegate: double)

        return (sut, double)
    }
}
