//
//  CharactersExplorerInteractor.swift
//  Dub Dub
//
//  Created by Yago Marques on 18/10/22.
//

import Foundation

protocol CharactersExplorerInteracting {
    var controllerDelegate: CharactersExplorerControllerDelegate? { get set }
    func findCharacters(page: Int, genres: String?, status: String?, species: String?)
    func loadCharactersNextPage(genres: String?, status: String?, species: String?)
}

protocol CharactersExplorerInteractorDelegate: AnyObject {
    func updateCollection()
    func modifyViewInractive(to state: Bool)
}

final class CharactersExplorerInteractor: CharactersExplorerInteracting {
    private let networkingWorker: CharacterNetworkWorking
    private var presenter: CharacterExplorerPresenting
    weak var controllerDelegate: CharactersExplorerControllerDelegate?

    init(
        networkingWorker: CharacterNetworkWorking,
        presenter: CharacterExplorerPresenting,
        controllerDelegate: CharactersExplorerControllerDelegate? = nil
    ) {
        self.networkingWorker = networkingWorker
        self.presenter = presenter
        self.controllerDelegate = controllerDelegate
        self.presenter.interactorDelegate = self
    }

    func findCharacters(page: Int, genres: String?, status: String?, species: String?) {
        networkingWorker.getCharacters(
            page: page,
            genres: genres,
            status: status,
            species: species
        ) { [weak self] result in
            if let self {
                if case let .success(characters) = result {
                    self.makeCharacters(characters: characters, isFirst: page == 1 ? true : false)
                }
            }
        }
    }

    func loadCharactersNextPage(genres: String?, status: String?, species: String?) {
        guard let nextPage = self.nextPage() else { return }

        self.findCharacters(
            page: nextPage,
            genres: genres,
            status: status,
            species: species
        )
    }

}

extension CharactersExplorerInteractor: CharactersExplorerInteractorDelegate {
    func updateCollection() {
        controllerDelegate?.updateCollection()
    }

    func modifyViewInractive(to state: Bool) {
        controllerDelegate?.viewIsInteractive(state)
    }
}

private extension CharactersExplorerInteractor {
    private func nextPage() -> Int? {
        if let next = self.presenter.characters.next {
            return next
        } else {
            return nil
        }
    }

    private func makeCharacters(characters: Characters, isFirst: Bool) {
        if isFirst {
            self.presenter.loadCharacters(with: characters)
        } else {
            self.presenter.updateCharacters(with: characters)
        }
    }
}

