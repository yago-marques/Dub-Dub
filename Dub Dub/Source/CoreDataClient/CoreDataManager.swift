//
//  CoreDataManager.swift
//  Dub Dub
//
//  Created by Yago Marques on 20/10/22.
//

import Foundation
import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Dub_Dub")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()

    @discardableResult
    func createChracter(with character: Character) -> CharacterEntity? {
        let context = persistentContainer.viewContext

        let characterEntity = CharacterEntity(context: context)

        characterEntity.name = character.name
        characterEntity.species = character.species
        characterEntity.status = character.status
        characterEntity.image = character.image
        characterEntity.gender = character.gender
        characterEntity.location = character.location

        do {
            try context.save()
            return characterEntity
        } catch let error {
            print("Failed to create: \(error)")
        }

        return nil
    }

    func fetchCharacters() -> [CharacterEntity]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")

        do {
            let characterEntities = try context.fetch(fetchRequest)
            return characterEntities
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }

        return nil
    }

}
