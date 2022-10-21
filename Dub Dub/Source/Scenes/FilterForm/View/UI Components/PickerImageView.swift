//
//  PickerImageView.swift
//  Dub Dub
//
//  Created by Yago Marques on 19/10/22.
//

import UIKit

final class PickerImageView: UIView {

    private let elements: [String]
    private var markedElement: IndexPath?
    private(set) var selectedItem: String?

    private lazy var itemsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 104, height: 80)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5

        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.register(PickerImageViewCell.self, forCellWithReuseIdentifier: "PickerImageViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false

        return myCollectionView
    }()

    init(elements: [String], selectedItem: String? = nil, markedElement: IndexPath? = nil) {
        self.selectedItem = selectedItem
        self.elements = elements
        self.markedElement = markedElement
        super.init(frame: .zero)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PickerImageView: UICollectionViewDelegate { }

extension PickerImageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = itemsCollection.dequeueReusableCell(withReuseIdentifier: "PickerImageViewCell", for: indexPath) as? PickerImageViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        if indexPath == self.markedElement {
            cell.selectedIcon.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            cell.selectedIcon.image = UIImage(systemName: "circle")
        }

        cell.element = self.elements[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = itemsCollection.cellForItem(at: indexPath) as? PickerImageViewCell else {
            return
        }

        if cell.selectedIcon.image == UIImage(systemName: "checkmark.circle.fill") {
            self.selectedItem = nil
            self.markedElement = nil

            DispatchQueue.main.async {
                cell.selectedIcon.image = UIImage(systemName: "circle")
            }

        } else {
            self.selectedItem = cell.element
            self.markedElement = indexPath

            let items = itemsCollection.numberOfItems(inSection: 0)
            let paths = (0..<items).map { item -> IndexPath in
                IndexPath(item: item, section: 0)
            }

            DispatchQueue.main.async {
                paths.forEach { [weak self] indexPath in
                    guard let self else { return }
                    let cell = self.itemsCollection.cellForItem(at: indexPath) as? PickerImageViewCell
                    cell?.selectedIcon.image = UIImage(systemName: "circle")
                }
                cell.selectedIcon.image = UIImage(systemName: "checkmark.circle.fill")
            }

        }
        
    }
}

extension PickerImageView: ViewCoding {
    func setupView() {

    }

    func setupHierarchy() {
        self.addSubview(itemsCollection)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemsCollection.topAnchor.constraint(equalTo: self.topAnchor),
            itemsCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemsCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemsCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
