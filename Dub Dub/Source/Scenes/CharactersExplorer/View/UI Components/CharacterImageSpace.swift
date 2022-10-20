//
//  CharacterImageSpace.swift
//  Dub Dub
//
//  Created by Yago Marques on 18/10/22.
//

import UIKit

final class CharacterImageSpace: UIView {

    var character: Character? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let self {
                    self.specieImage.image = UIImage(named: self.character?.species ?? "unknown")
                    self.statusImage.image = UIImage(named: self.character?.status ?? "unknown")
                    self.genreImage.image = UIImage(named: self.character?.gender ?? "unknown")

                    if let image = self.character?.image {
                        self.characterImage.downloaded(from: URL(string: image)!)
                    }
                }
            }
        }
    }

    private lazy var characterImage: UIImageView = {
        self.getDefaultUIImageView()
    }()

    private lazy var statusImage: UIImageView = {
        self.getDefaultUIImageView()
    }()

    private lazy var genreImage: UIImageView = {
        self.getDefaultUIImageView()
    }()

    private lazy var specieImage: UIImageView = {
        self.getDefaultUIImageView()
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

private extension CharacterImageSpace {
    private func getDefaultUIImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }
}

extension CharacterImageSpace: ViewCoding {
    func setupView() { }

    func setupHierarchy() {
        let views: [UIView] = [
            characterImage,
            specieImage,
            statusImage,
            genreImage
        ]

        views.forEach { self.addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: self.topAnchor),
            characterImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            characterImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            specieImage.topAnchor.constraint(equalToSystemSpacingBelow: characterImage.topAnchor, multiplier: 2),
            specieImage.leadingAnchor.constraint(equalToSystemSpacingAfter: characterImage.leadingAnchor, multiplier: 2),

            statusImage.trailingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: -10),
            statusImage.bottomAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: -10),

            genreImage.trailingAnchor.constraint(equalTo: statusImage.leadingAnchor, constant: -10),
            genreImage.bottomAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: -10)
        ])
    }
}
