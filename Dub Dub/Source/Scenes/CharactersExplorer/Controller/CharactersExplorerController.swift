//
//  CharactersExplorerController.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import UIKit

protocol CharactersExplorerControllerDelegate: AnyObject {
    func updateCollection()
    func viewIsInteractive(_ state: Bool)
}

protocol CharactersExplorerControlling {
    var presenterDelegate: CharacterExplorerPresenterDelegate? { get }
    func loadNextPage()
}

protocol ExplorerAndFilterMediation {
    func modifyFilter(with newFilter: CharacterFilter)
}

final class CharactersExplorerController: UIViewController, CharactersExplorerControlling {

    weak var presenterDelegate: CharacterExplorerPresenterDelegate?
    private var interactor: CharactersExplorerInteracting
    private var router: CharactersExplorerRouting
    private let characterView: CharactersExplorerView

    init(
        view: CharactersExplorerView,
        interactor: CharactersExplorerInteracting,
        presenterDelegate: CharacterExplorerPresenterDelegate,
        router: CharactersExplorerRouting
    ) {
        self.interactor = interactor
        self.characterView = view
        self.presenterDelegate = presenterDelegate
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = characterView
        self.interactor.controllerDelegate = self
        self.characterView.controller = self
        self.router.navigationController = self.navigationController
        self.router.mediator = self
        addBarItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        interactor.findCharacters(
            page: 1,
            genres: self.presenterDelegate?.filterQueries.genres,
            status: self.presenterDelegate?.filterQueries.status,
            species: self.presenterDelegate?.filterQueries.species
        )
    }

    func loadNextPage() {
        interactor.loadCharactersNextPage(
            genres: self.presenterDelegate?.filterQueries.genres,
            status: self.presenterDelegate?.filterQueries.status,
            species: self.presenterDelegate?.filterQueries.species
        )
    }

}

extension CharactersExplorerController: CharactersExplorerControllerDelegate {

    func updateCollection() {
        DispatchQueue.main.async { [weak self] in
            if let self {
                self.characterView.charactersCollection.reloadData()
            }
        }
    }

    func viewIsInteractive(_ state: Bool) {
        DispatchQueue.main.async { [weak self] in
            if let self {
                self.characterView.isUserInteractionEnabled = state
            }
        }
    }

    @objc func printer() {
        print("search")
    }

    @objc func showFilter() {
        router.navigateToFilter()
    }
    
}

extension CharactersExplorerController: ExplorerAndFilterMediation {
    func modifyFilter(with newFilter: CharacterFilter) {
        self.presenterDelegate?.filterQueries = newFilter

        interactor.findCharacters(
            page: 1,
            genres: self.presenterDelegate?.filterQueries.genres,
            status: self.presenterDelegate?.filterQueries.status,
            species: self.presenterDelegate?.filterQueries.species
        )
    }
}

private extension CharactersExplorerController {
    private func addBarItems() {
        let filterBarItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(showFilter))

        let searchBarItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(printer))

        self.navigationItem.rightBarButtonItems = [filterBarItem, searchBarItem]
    }
}
