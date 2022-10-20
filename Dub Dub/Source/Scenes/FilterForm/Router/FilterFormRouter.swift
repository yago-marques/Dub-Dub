//
//  FilterFormRouter.swift
//  Dub Dub
//
//  Created by Yago Marques on 20/10/22.
//

import UIKit

protocol FilterFormRouting {
    var navigationController: UINavigationController? { get set }
    func backToExplorer()
}

final class FilterFormRouter: FilterFormRouting {

    var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func backToExplorer() {
        navigationController?.dismiss(animated: true)
    }

}
