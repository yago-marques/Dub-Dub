//
//  CharactersExplorerRouter.swift
//  Dub Dub
//
//  Created by Yago Marques on 19/10/22.
//

import UIKit

protocol CharactersExplorerRouting {
    var navigationController: UINavigationController? { get set }
    var mediator: ExplorerAndFilterMediation? { get set }
    func navigateToFilter()
}

final class CharactersExplorerRouter: CharactersExplorerRouting {

    var navigationController: UINavigationController?
    var mediator: ExplorerAndFilterMediation?
    var factory: FilterFormFactoring

    init(
        navigationController: UINavigationController? = nil,
        mediator: ExplorerAndFilterMediation? = nil,
        factory: FilterFormFactoring = FilterFormFactory()
    ) {
        self.mediator = mediator
        self.navigationController = navigationController
        self.factory = factory
    }

    func navigateToFilter() {
        if let navigation = navigationController, let mediator = self.mediator {
            navigationController?.present(
                factory.make(navigation: navigation, mediator: mediator),
                animated: true
            )
        }
    }

}
