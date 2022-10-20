//
//  FilterFormFactory.swift
//  Dub Dub
//
//  Created by Yago Marques on 19/10/22.
//

import UIKit

enum FilterFormFactory {
    static func make(navigation: UINavigationController, mediator: ExplorerAndFilterMediation) -> UIViewController {
        let view = FilterFormView(frame: UIScreen.main.bounds)
        let presenter = FilterFormPresenter()
        let interactor = FilterFormInteractor(presenter: presenter)
        let router = FilterFormRouter()
        return FilterFormController(
            view: view,
            interactor: interactor,
            router: router,
            navigation: navigation,
            mediator: mediator
        )
    }
}
