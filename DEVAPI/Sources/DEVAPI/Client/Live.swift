//
//  Live.swift
//  
//
//  Created by Hadi on 08/04/2021.
//

import Combine
import Foundation

// swiftlint:disable trailing_closure
public extension DEVClient {
    static let live = Self(
        articles: {
            Articles(
                latest: { queryItems in
                    URLSession.shared.dataTaskPublisher(for: url(for: "articles/latest", with: queryItems))
                        .map { data, _ in data }
                        .decode(type: [Article].self, decoder: jsonDecoder)
                        .eraseToAnyPublisher()
                }
            )
        }
    )
}

public extension DEVClient.Articles {
    static let live = Self(
        latest: { queryItems in
            URLSession.shared.dataTaskPublisher(for: url(for: "articles/latest", with: queryItems))
                .map { data, _ in data }
                .decode(type: [Article].self, decoder: jsonDecoder)
                .eraseToAnyPublisher()
        }
    )
}

private func url(for endPoint: String, with queryItems: [DEVQueryItem] = []) -> URL {
    var urlComponents = URLComponents()
    urlComponents.queryItems = queryItems.urlQueryItems()
    urlComponents.scheme = "https"
    urlComponents.host = "dev.to"
    urlComponents.path = "/api/\(endPoint)"
    return urlComponents.url!
}
