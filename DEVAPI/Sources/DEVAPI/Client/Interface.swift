//
//  File.swift
//  
//
//  Created by Hadi on 08/04/2021.
//

import Combine
import Foundation

public struct DEVClient {
    public var articles: () -> Articles
}

public extension DEVClient {
    struct Articles {
        public var latest: ([DEVQueryItem]) -> AnyPublisher<[Article], Error>
    }
}

let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .iso8601
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return jsonDecoder
}()
