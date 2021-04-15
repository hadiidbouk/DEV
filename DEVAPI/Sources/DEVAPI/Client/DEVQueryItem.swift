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
    case tag(String)
    case tags(String)
    case tagsExclude(String)
    case username(String)
    case state(State)
    case top(Int)
    case collectionId(Int)

    var urlQueryItem: URLQueryItem { .init(name: name, value: value) }

    public enum State: String {
        case fresh
        case rising
        case all
    }
}

private extension DEVQueryItem {
    var name: String {
        switch self {
        case .page:
            return "page"
        case .perPage:
            return "per_page"
        case .tag:
            return "tag"
        case .tags:
            return "tags"
        case .tagsExclude:
            return "tags_exclude"
        case .username:
            return "username"
        case .state:
            return "state"
        case .top:
            return "top"
        case .collectionId:
            return "collection_id"
        }
    }

    var value: String {
        switch self {
        case .page(let value),
             .perPage(let value),
             .top(let value),
             .collectionId(let value):
            return String(value)
        case .tag(let value),
             .tags(let value),
             .tagsExclude(let value),
             .username(let value):
            return value
        case let .state(state):
            return state.rawValue
        }
    }
}

extension Array where ArrayLiteralElement == DEVQueryItem {
    func urlQueryItems() -> [URLQueryItem] { map(\.urlQueryItem) }
}
