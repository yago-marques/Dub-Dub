//
//  ControllerPresenterDelegateStub.swift
//  Dub DubTests
//
//  Created by Yago Marques on 23/10/22.
//

import XCTest
@testable import Dub_Dub

final class ControllerPresenterDelegateStub: CharacterExplorerPresenterDelegate {
    var characters: Dub_Dub.Characters = CharactersConstants.getCharacters()

    var filterQueries: Dub_Dub.CharacterFilter = Dub_Dub.CharacterFilter()
}

extension ControllerPresenterDelegateStub {
    func activeFilter() {
        self.filterQueries.status = "Human"
    }
}
