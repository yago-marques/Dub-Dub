//
//  InteractorNetworkingWorkerSpy.swift
//  Dub DubTests
//
//  Created by Yago Marques on 22/10/22.
//

import XCTest
@testable import Dub_Dub

final class InteractorNetworkingWorkerSpy: CharacterNetworkWorking {

    var connectionIsOn = true
    private var charactersMock = Characters(count: 1, next: 2, data: [Dub_Dub.Character(name: "", status: "", species: "", gender: "", image: Data(), imageUrl: "", location: "")])

    enum Messages: Equatable {
        case charactersReturned
        case filteredCharactersReturned
        case errorReturned
    }

    private(set) var receivedMessages = [Messages]()

    func getCharacters(page: Int, genres: String?, status: String?, species: String?, completion: @escaping (Result<Dub_Dub.Characters, Error>) -> Void) {
        charactersMock.next = page + 1
        if connectionIsOn {
            if genres != nil || status != nil || species != nil {
                receivedMessages.append(.filteredCharactersReturned)
                completion(.success(charactersMock))
            } else {
                completion(.success(charactersMock))
                receivedMessages.append(.charactersReturned)
            }
        } else {
            completion(.failure(APICallError.invalidUrl))
            receivedMessages.append(.errorReturned)
        }
    }

}
