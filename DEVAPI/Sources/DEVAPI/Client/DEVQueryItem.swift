//
//  DEVQueryItem.swift
//  
//
//  Created by Hadi on 08/04/2021.
//

import Foundation

public enum DEVQueryItem: Equatable {
    case page(Int)
    case perPage(Int)

    var urlQueryItem: URLQueryItem {
        switch self {
        case let .page(value):       return URLQueryItem(name: "page", value: String(value))
        case let .perPage(value):    return URLQueryItem(name: "perPage", value: String(value))
        }
    }
}

extension Array where ArrayLiteralElement == DEVQueryItem {
    func urlQueryItems() -> [URLQueryItem] { map(\.urlQueryItem) }
}
