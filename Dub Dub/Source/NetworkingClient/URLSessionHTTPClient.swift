//
//  URLSessionClient.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import Foundation

protocol HTTPSClient {
    func get(endpoint: EndpointProtocol, completion: @escaping (Result<(Data, HTTPURLResponse), APICallError>) -> Void)
}

final class URLSessionHTTPClient: HTTPSClient {

    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func get(endpoint: EndpointProtocol, completion: @escaping (Result<(Data, HTTPURLResponse), APICallError>) -> Void) {
        guard let url = endpoint.makeURL() else {
            return completion(.failure(.invalidUrl))
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpMethod = endpoint.httpMethod.rawValue

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.network(error)))
            }

            if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            }
        }

        task.resume()
    }
}
