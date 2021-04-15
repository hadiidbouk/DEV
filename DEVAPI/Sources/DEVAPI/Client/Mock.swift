//
//  Mock.swift
//  
//
//  Created by Hadi on 08/04/2021.
//

import Combine
import Foundation

// swiftlint:disable trailing_closure
public extension DEVClient {
    static let mock = Self(
        articles: { .mock }
    )
}

public extension DEVClient.Articles {
    static let mock = Self(
        latest: { _ in
            Just(fetchArticles(from: "articles-latest"))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    )
}

private func fetchArticles(from fileName: String) -> [Article] {
    decode(from: fileName)
}

private func decode<T: Decodable>(from fileName: String) -> T {
    do {
        guard  let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
            fatalError("Cannot find \(fileName).")
        }
        let data = try Data(contentsOf: url)
        return try jsonDecoder.decode(T.self, from: data)
    } catch let error {
        fatalError(error.localizedDescription)
    }
}
