//
//  CharactersExplorerFactory.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import UIKit

enum CharactersExplorerFactory {
    static func make() -> CharactersExplorerController {
        let view = CharactersExplorerView(frame: UIScreen.main.bounds)
        let networkingWorker = CharacterNetworkingWorker(api: URLSessionHTTPClient(session: URLSession.shared))
        let presenter = CharacterExplorerPresenter()
        let interactor = CharactersExplorerInteractor(networkingWorker: networkingWorker, presenter: presenter)
        let router = CharactersExplorerRouter()
        return CharactersExplorerController(
            view: view,
            interactor: interactor,
            presenterDelegate: presenter,
            router: router
        )
    }
}
