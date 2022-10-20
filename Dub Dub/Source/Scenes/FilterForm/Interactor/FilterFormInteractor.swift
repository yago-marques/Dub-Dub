//
//  FilterFormInteractor.swift
//  Dub Dub
//
//  Created by Yago Marques on 20/10/22.
//

import Foundation

protocol FilterFormInteracting {
    var controllerDelegate: FilterFormControllerDelegate? { get set }
    func makeFilter(with filter: CharacterFilter)
}

protocol FilterFormInteractorDelegate: AnyObject {
    func updateFilter(with newFilter: CharacterFilter)
}

final class FilterFormInteractor: FilterFormInteracting {

    weak var controllerDelegate: FilterFormControllerDelegate?
    private var presenter: FilterFormPresenting

    init(
        controllerDelegate: FilterFormControllerDelegate? = nil,
        presenter: FilterFormPresenting
    ) {
        self.presenter = presenter
        self.controllerDelegate = controllerDelegate
        self.presenter.controllerDelegate = self
    }

    func makeFilter(with filter: CharacterFilter) {
        var filter = filter
        if let status = filter.status {
            filter.status = status.lowercased()
        }

        if let genres = filter.genres {
            filter.genres = genres.lowercased()
        }

        if let species = filter.species {
            filter.species = species.lowercased()
        }

        presenter.updateFilter(with: filter)
    }

}

extension FilterFormInteractor: FilterFormInteractorDelegate {
    func updateFilter(with newFilter: CharacterFilter) {
        controllerDelegate?.updateFilter(with: newFilter)
    }
}
