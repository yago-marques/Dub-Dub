//
//  FilterFormPresenter.swift
//  Dub Dub
//
//  Created by Yago Marques on 20/10/22.
//

import Foundation

protocol FilterFormPresenting {
    var controllerDelegate: FilterFormInteractorDelegate? { get set }
    func updateFilter(with newFilter: CharacterFilter)
}

final class FilterFormPresenter: FilterFormPresenting {

    weak var controllerDelegate: FilterFormInteractorDelegate?

    init(controllerDelegate: FilterFormInteractorDelegate? = nil) {
        self.controllerDelegate = controllerDelegate
    }

    func updateFilter(with newFilter: CharacterFilter) {
        controllerDelegate?.updateFilter(with: newFilter)
    }
    
}

