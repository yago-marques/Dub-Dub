//
//  CharacterCoreDataWorker.swift
//  Dub Dub
//
//  Created by Yago Marques on 20/10/22.
//

import Foundation
import CoreData

protocol CharacterCoreDataWorking {
    func get() -> [Character?]?
    func post(with character: Character)
}

final class CharacterCoreDataWorker: CharacterCoreDataWorking {

    let coreData: CoreDataManaging

    init(coreData: CoreDataManaging) {
        self.coreData = coreData
    }

    func get() -> [Character?]? {
        guard let charactersEntities = coreData.fetchCharacters() else { return nil }

        let characters = charactersEntities.map { entity -> Character? in
            self.makeCharacters(with: entity)
        }

        return characters
    }

    func post(with character: Character) {
        coreData.createChracter(with: character)
    }

    private func makeCharacters(with entity: CharacterEntity) -> Character? {
        if
            let name = entity.name,
            let status = entity.status,
            let species = entity.species,
            let gender = entity.gender,
            let image = entity.image,
            let location = entity.location
        {
            let character = Character(
                name: name,
                status: status,
                species: species,
                gender: gender,
                image: image,
                imageUrl: nil,
                location: location
            )

            return character
        } else { return nil }
    }

}
