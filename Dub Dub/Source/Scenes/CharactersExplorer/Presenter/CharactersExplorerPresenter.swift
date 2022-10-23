//
//  CharactersExplorerPresenter.swift
//  Dub Dub
//
//  Created by Yago Marques on 18/10/22.
//

import Foundation

protocol CharacterExplorerPresenting {
    var characters: Characters { get set }
    var interactorDelegate: CharactersExplorerInteractorDelegate? { get set }
    func loadCharacters(with characters: Characters)
    func updateCharacters(with characters: Characters)
}

protocol CharacterExplorerPresenterDelegate: AnyObject {
    var characters: Characters { get set }
    var filterQueries: CharacterFilter { get set }
}

final class CharacterExplorerPresenter: CharacterExplorerPresenting, CharacterExplorerPresenterDelegate {

    var characters = Characters(count: 0, next: nil, prev: nil, data: []) {
        didSet {
            self.interactorDelegate?.updateCollection()
        }
    }
    var filterQueries = CharacterFilter(genres: nil, status: nil, species: nil)

    weak var interactorDelegate: CharactersExplorerInteractorDelegate?

    init(interactorDelegate: CharactersExplorerInteractorDelegate? = nil) {
        self.interactorDelegate = interactorDelegate
    }

    func loadCharacters(with characters: Characters) {
        self.characters = characters
    }

    func updateCharacters(with characters: Characters) {
        self.characters.next = characters.next
        self.characters.prev = characters.prev

        characters.data.forEach { [weak self] character in
            if let self {
                if self.characters.data.firstIndex(of: character) == nil {
                    self.characters.data.append(character)
                }
            }
        }
    }

}
