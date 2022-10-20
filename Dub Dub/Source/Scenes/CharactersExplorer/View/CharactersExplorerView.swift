//
//  CharacterExplorerView.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import UIKit

final class CharactersExplorerView: UIView {

    var controller: CharactersExplorerControlling?

    lazy var charactersCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = self.frame.width
        layout.itemSize = CGSize(width: self.frame.width, height: width*1.45)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0

        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.register(CharacterBigCell.self, forCellWithReuseIdentifier: "CharacterBigCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false

        return myCollectionView
    }()

    init(frame: CGRect, controller: CharactersExplorerControlling? = nil) {
        self.controller = controller
        super.init(frame: frame)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

}

extension CharactersExplorerView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y / self.frame.width*0.75
        if let count = self.controller?.presenterDelegate?.characters.data.count, count != 0 {
            if Int(scrollPosition) == count {
                controller?.loadNextPage()
            }
        }
    }
}

extension CharactersExplorerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.controller?.presenterDelegate?.characters.data.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = charactersCollection.dequeueReusableCell(
            withReuseIdentifier: "CharacterBigCell", for: indexPath
        ) as? CharacterBigCell else {
            return UICollectionViewCell(frame: .zero)
        }

        if let character = self.controller?.presenterDelegate?.characters.data {
            cell.character = character[indexPath.row]
        }

        return cell
    }
}

extension CharactersExplorerView: ViewCoding {
    func setupView() {
        self.backgroundColor = .systemBackground
    }

    func setupHierarchy() {
        self.addSubview(charactersCollection)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            charactersCollection.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            charactersCollection.widthAnchor.constraint(equalTo: self.widthAnchor),
            charactersCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            charactersCollection.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
