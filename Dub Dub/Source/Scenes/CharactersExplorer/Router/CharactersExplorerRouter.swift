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

    init(
        navigationController: UINavigationController? = nil,
        mediator: ExplorerAndFilterMediation? = nil
    ) {
        self.mediator = mediator
        self.navigationController = navigationController
    }

    func navigateToFilter() {
        if let navigation = navigationController, let mediator = self.mediator {
            navigationController?.present(
                FilterFormFactory.make(navigation: navigation, mediator: mediator),
                animated: true
            )
        }
    }

}
