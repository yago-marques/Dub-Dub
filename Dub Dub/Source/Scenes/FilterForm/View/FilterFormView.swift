//
//  FilterFormView.swift
//  Dub Dub
//
//  Created by Yago Marques on 19/10/22.
//

import UIKit

final class FilterFormView: UIView {

    var controller: FilterFormControlling?

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filter By:"
        label.font = UIFont.systemFont(ofSize: 27, weight: .heavy)

        return label
    }()

    private lazy var speciesLabel: UILabel = {
        self.getDefaultUILabel(text: "Species")
    }()

    private(set) var speciesPicker: PickerImageView = {
        let picker = PickerImageView(elements: CharacterInfo.getSpecies())
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    private lazy var genresLabel: UILabel = {
        self.getDefaultUILabel(text: "Genres")
    }()

    private(set) var genresPicker: PickerImageView = {
        let picker = PickerImageView(elements: CharacterInfo.getGenres())
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    private lazy var statusLabel: UILabel = {
        self.getDefaultUILabel(text: "Status")
    }()

    private(set) var statusPicker: PickerImageView = {
        let picker = PickerImageView(elements: CharacterInfo.getStatus())
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    private lazy var filterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Filter it now", for: .normal)
        button.addTarget(self, action: #selector(filterItNow), for: .touchUpInside)
        button.backgroundColor = .tintColor
        button.layer.cornerCurve = .circular
        button.layer.cornerRadius = 10

        return button
    }()

    init(frame: CGRect, controller: FilterFormControlling? = nil) {
        self.controller = controller
        super.init(frame: frame)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    @objc func filterItNow() {
        if let controller = self.controller {
            controller.filterItNow()
        }
    }

}

private extension FilterFormView {
    private func getDefaultUILabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = text
        label.textColor = .secondaryLabel

        return label
    }
}

extension FilterFormView: ViewCoding {
    func setupView() {
        self.backgroundColor = .systemBackground
    }

    func setupHierarchy() {
        let views: [UIView] = [
            titleLabel,
            speciesLabel,
            speciesPicker,
            genresLabel,
            genresPicker,
            statusLabel,
            statusPicker,
            filterButton
        ]

        views.forEach { self.addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 3),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            speciesLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            speciesLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            speciesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            speciesPicker.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor),
            speciesPicker.widthAnchor.constraint(equalTo: self.widthAnchor),
            speciesPicker.heightAnchor.constraint(equalTo: speciesPicker.widthAnchor, multiplier: 0.34),

            genresLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            genresLabel.topAnchor.constraint(equalTo: speciesPicker.bottomAnchor),
            genresLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            genresPicker.topAnchor.constraint(equalTo: genresLabel.bottomAnchor),
            genresPicker.widthAnchor.constraint(equalTo: self.widthAnchor),
            genresPicker.heightAnchor.constraint(equalTo: genresPicker.widthAnchor, multiplier: 0.3),

            statusLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            statusLabel.topAnchor.constraint(equalTo: genresPicker.bottomAnchor),
            statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            statusPicker.topAnchor.constraint(equalTo: statusLabel.bottomAnchor),
            statusPicker.widthAnchor.constraint(equalTo: self.widthAnchor),
            statusPicker.heightAnchor.constraint(equalTo: statusPicker.widthAnchor, multiplier: 0.3),

            filterButton.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 0.9),
            filterButton.heightAnchor.constraint(equalTo: filterButton.widthAnchor, multiplier: 0.2),
            filterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            filterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
