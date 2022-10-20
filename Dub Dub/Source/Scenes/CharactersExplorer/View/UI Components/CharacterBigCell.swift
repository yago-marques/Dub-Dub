//
//  CharacterBigCell.swift
//  Dub Dub
//
//  Created by Yago Marques on 18/10/22.
//

import UIKit

final class CharacterBigCell: UICollectionViewCell {

    var character: Character? {
        didSet {
            characterImage.character = character
            textContent.character = character
        }
    }

    private let characterImage: CharacterImageSpace = {
        let image = CharacterImageSpace()
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private let textContent: CharacterTextContent = {
        let content = CharacterTextContent()
        content.translatesAutoresizingMaskIntoConstraints = false

        return content
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CharacterBigCell: ViewCoding {
    func setupView() { }

    func setupHierarchy() {
        let views: [UIView] = [
            characterImage,
            textContent
        ]

        views.forEach { self.addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: self.topAnchor),
            characterImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            characterImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            characterImage.heightAnchor.constraint(equalTo: characterImage.widthAnchor),

            textContent.topAnchor.constraint(equalToSystemSpacingBelow: characterImage.bottomAnchor, multiplier: 3),
            textContent.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            textContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textContent.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
