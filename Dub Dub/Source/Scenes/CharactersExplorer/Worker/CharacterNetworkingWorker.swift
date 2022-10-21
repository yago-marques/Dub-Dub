//
//  NetworkingWorker.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import Foundation

protocol CharacterNetworkWorking {
    func getCharacters(
        page: Int,
        genres: String?,
        status: String?,
        species: String?,
        completion: @escaping (Result<Characters, Error>) -> Void
    )
}

final class CharacterNetworkingWorker {
    let api: HTTPSClient

    init(api: HTTPSClient) {
        self.api = api
    }
}

extension CharacterNetworkingWorker: CharacterNetworkWorking {
    func getCharacters(
        page: Int,
        genres: String?,
        status: String?,
        species: String?,
        completion: @escaping (Result<Characters, Error>) -> Void
    ) {
        fetchCharactersResponse(
            page: page,
            genres: genres,
            status: status,
            species: species
        ) { [weak self] result in
            if let self {
                switch result {
                case let .success(charactersResponse):
                    self.makeCharacters(with: charactersResponse) { characters in
                        completion(.success(characters))
                    }
                case let .failure(failure):
                    completion(.failure(failure))
                }
            }
        }
    }
}

private extension CharacterNetworkingWorker {
    private func fetchCharactersResponse(
        page: Int,
        genres: String?,
        status: String?,
        species: String?,
        completion: @escaping (Result<APICharacters, Error>) -> Void) {
        api.get(endpoint: CharactersEndpoint(page: page, species: species, genres: genres, status: status)) { result in
            if case let .success((data, _)) = result {
                do {
                    let apiResponse = try JSONDecoder().decode(APICharacters.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    private func makeCharacters(with charactersResponse: APICharacters, completion: @escaping (Characters) -> Void) {
        var characterGroup = Characters(
            count: charactersResponse.info.count,
            next: getPage(stringPage: charactersResponse.info.next),
            prev: getPage(stringPage: charactersResponse.info.prev),
            data: []
        )

        charactersResponse.results.forEach { result in
            self.fetchImage(with: result.image) { imageResult in
                if let imageResult {
                    let character = Character(
                        name: result.name,
                        status: result.status,
                        species: result.species,
                        gender: result.gender,
                        image: imageResult,
                        imageUrl: result.image,
                        location: result.location.name
                    )

                    characterGroup.data.append(character)
                }

                if characterGroup.data.count == charactersResponse.results.count {
                    completion(characterGroup)
                }
            }
        }
    }

    private func getPage(stringPage: String?) -> Int? {
        let index = APIConstants.Numbers.pageUrlCountWithoutPageNumber.rawValue
        if let stringPage, let page = Int(stringPage[index..<index+1]) {
            return page
        } else {
            return nil
        }
    }

    private func fetchImage(with imagePath: String, completion: @escaping (Data?) -> Void) {
        let endpoint = CharacterImageEndpoint(path: imagePath[APIConstants.Numbers.pathImageWithoutBaseUrl.rawValue...])
        api.get(endpoint: endpoint) { result in
            if case let .success((data, _)) = result {
                completion(data)
            }
        }
    }
}
