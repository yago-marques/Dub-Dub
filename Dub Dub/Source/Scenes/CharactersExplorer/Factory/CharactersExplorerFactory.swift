//
//  CharactersExplorerFactory.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import UIKit

enum CharactersExplorerFactory {
    static func make() -> UIViewController {
        let view = CharactersExplorerView(frame: UIScreen.main.bounds)
        let networkingWorker = CharacterNetworkingWorker(api: URLSessionHTTPClient(session: URLSession.shared))
        let coreDataWorker = CharacterCoreDataWorker()
        let presenter = CharacterExplorerPresenter()
        let interactor = CharactersExplorerInteractor(networkingWorker: networkingWorker, presenter: presenter, coreDataWorker: coreDataWorker)
        let router = CharactersExplorerRouter()
        return CharactersExplorerController(
            view: view,
            interactor: interactor,
            presenterDelegate: presenter,
            router: router
        )
    }
}
