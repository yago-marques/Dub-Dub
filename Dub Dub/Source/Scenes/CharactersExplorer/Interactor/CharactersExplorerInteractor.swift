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
    private let coreDataWorker: CharacterCoreDataWorking
    private var presenter: CharacterExplorerPresenting
    weak var controllerDelegate: CharactersExplorerControllerDelegate?

    init(
        networkingWorker: CharacterNetworkWorking,
        presenter: CharacterExplorerPresenting,
        controllerDelegate: CharactersExplorerControllerDelegate? = nil,
        coreDataWorker: CharacterCoreDataWorking
    ) {
        self.networkingWorker = networkingWorker
        self.presenter = presenter
        self.controllerDelegate = controllerDelegate
        self.coreDataWorker = coreDataWorker
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
                } else {
                    self.useCoredata()
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
            self.storeOnCoreData(characters)

            self.presenter.loadCharacters(with: characters)
        } else {
            self.presenter.updateCharacters(with: characters)
        }
    }

    private func storeOnCoreData(_ characters: Characters) {
        guard let isEmpty = self.coreDataIsEmpty() else { return }

        if isEmpty {
            characters.data.forEach { character in
                self.coreDataWorker.post(with: character)
            }
        }
    }

    private func coreDataIsEmpty() -> Bool? {
        guard let coreData = coreDataWorker.get() else { return nil }

        return coreData.isEmpty
    }

    private func useCoredata() {
        if let coreData = self.coreDataWorker.get() {
            var charactersData: [Character] = []

            coreData.forEach {
                guard let character = $0 else { return }

                charactersData.append(character)
            }

            let chashedCharacters = Characters(count: charactersData.count, data: charactersData)
            self.makeCharacters(characters: chashedCharacters, isFirst: true)
        }
    }
}
