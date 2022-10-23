//
//  ViewCoding.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import Foundation

protocol ViewCoding {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCoding {
    func buildLayout() {
        setupView()
        setupHierarchy()
        setupConstraints()
    }
}
