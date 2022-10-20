//
//  APICallError.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import Foundation

enum APICallError: Error {
    case invalidUrl
    case network(Error)
}
