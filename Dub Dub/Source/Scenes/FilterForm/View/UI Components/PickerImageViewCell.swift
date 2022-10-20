//
//  PickerImageViewCell.swift
//  Dub Dub
//
//  Created by Yago Marques on 19/10/22.
//

import UIKit

final class PickerImageViewCell: UICollectionViewCell {

    var element: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let self {
                    self.elementImage.image = UIImage(named: self.element)
                    self.elementLabel.text = self.element
                }
            }
        }
    }

    private let elementImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    var selectedIcon: UIImageView = {
        let circle = UIImageView(image: UIImage(systemName: "circle"))
        circle.translatesAutoresizingMaskIntoConstraints = false

        return circle
    }()

    private let elementLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PickerImageViewCell: ViewCoding {
    func setupView() { }

    func setupHierarchy() {
        let views: [UIView] = [
            elementImage,
            elementLabel,
            selectedIcon
        ]

        views.forEach { self.addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            elementImage.topAnchor.constraint(equalTo: self.topAnchor),
            elementImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            selectedIcon.centerXAnchor.constraint(equalTo: elementImage.centerXAnchor),
            selectedIcon.centerYAnchor.constraint(equalTo: elementImage.centerYAnchor),

            elementLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            elementLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            elementLabel.topAnchor.constraint(equalToSystemSpacingBelow: elementImage.bottomAnchor, multiplier: 1)
        ])
    }
}
