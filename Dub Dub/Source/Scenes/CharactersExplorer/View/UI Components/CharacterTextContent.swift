//
//  CharacterTextContent.swift
//  Dub Dub
//
//  Created by Yago Marques on 18/10/22.
//

import UIKit

final class CharacterTextContent: UIView {

    var character: Character? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let self, let character = self.character {
                    self.nameLabel.text = character.name
                    self.genreLabel.text = character.gender.appending(" |")
                    self.statusLabel.text = character.status
                    self.speciesLabel.text = "species: ".appending(character.species)
                    self.locationLabel.text = character.location
                }
            }
        }
    }

    private lazy var nameLabel: UILabel = {
        let label = self.getDefaultUILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)

        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = self.getDefaultUILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        return label
    }()

    private lazy var genreLabel: UILabel = {
        let label = self.getDefaultUILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        return label
    }()

    private let locationImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "location.circle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .secondaryLabel

        return imageView
    }()

    private lazy var speciesLabel: UILabel = {
        let label = self.getDefaultUILabel()
        label.textColor = .secondaryLabel

        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = self.getDefaultUILabel()
        label.textColor = .secondaryLabel

        return label
    }()

    init(character: Character? = nil) {
        self.character = character
        super.init(frame: .zero)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension CharacterTextContent {
    private func getDefaultUILabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }
}

extension CharacterTextContent: ViewCoding {
    func setupView() { }

    func setupHierarchy() {
        let views: [UIView] = [
            nameLabel,
            statusLabel,
            genreLabel,
            speciesLabel,
            locationImage,
            locationLabel
        ]

        views.forEach { self.addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55),

            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),

            genreLabel.trailingAnchor.constraint(equalTo: statusLabel.leadingAnchor, constant: -5),
            genreLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),

            speciesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            speciesLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 2),

            locationImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            locationImage.topAnchor.constraint(equalToSystemSpacingBelow: speciesLabel.bottomAnchor, multiplier: 1.3),

            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: locationImage.trailingAnchor, multiplier: 1),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
