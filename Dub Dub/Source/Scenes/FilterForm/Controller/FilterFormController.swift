//
//  FilterFormController.swift
//  Dub Dub
//
//  Created by Yago Marques on 19/10/22.
//

import UIKit

protocol FilterFormControlling {
    func filterItNow()
}

protocol FilterFormControllerDelegate: AnyObject {
    func updateFilter(with newFilter: CharacterFilter)
}

final class FilterFormController: UIViewController {

    private var filter = CharacterFilter() {
        didSet {
            mediator.modifyFilter(with: self.filter)
        }
    }

    private var filterView: FilterFormView
    private var interactor: FilterFormInteracting
    private var router: FilterFormRouting
    private let mediator: ExplorerAndFilterMediation

    init(
        view: FilterFormView,
        interactor: FilterFormInteracting,
        router: FilterFormRouting,
        navigation: UINavigationController?,
        mediator: ExplorerAndFilterMediation
    ) {
        self.filterView = view
        self.interactor = interactor
        self.router = router
        self.mediator = mediator
        super.init(nibName: nil, bundle: nil)
        self.view = view
        self.filterView.controller = self
        self.router.navigationController = navigation
        self.interactor.controllerDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FilterFormController: FilterFormControlling {
    func filterItNow() {
        interactor.makeFilter(with: self.getUserFilter())

        router.backToExplorer()
    }
}

extension FilterFormController: FilterFormControllerDelegate {
    func updateFilter(with newFilter: CharacterFilter) {
        self.filter = newFilter
    }
}

private extension FilterFormController {
    private func getUserFilter() -> CharacterFilter {
        CharacterFilter(
            genres: self.filterView.genresPicker.selectedItem,
            status: self.filterView.statusPicker.selectedItem,
            species: self.filterView.speciesPicker.selectedItem
        )
    }
}
