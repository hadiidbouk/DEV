//
//  AppCore.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import ComposableArchitecture

struct AppState {
    var feed = FeedState()
}

enum AppAction {
    case feed(FeedAction)
}

struct AppEnvironment {
    let feedEnvironment: FeedEnvironment
}

let appReducer = Reducer.combine(
    Reducer<AppState, AppAction, AppEnvironment>() { _, action, _ in
        switch action {
        case .feed:
            return .none
        }
    },

    feedReducer.pullback(state: \.feed,
                         action: /AppAction.feed,
                         environment: \.feedEnvironment)
)
