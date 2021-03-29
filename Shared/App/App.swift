//
//  DEVApp.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import ComposableArchitecture
import SwiftUI

@main
struct DEVApp: App {
    var body: some Scene {
        let windowGroup = WindowGroup {
            let store = Store(initialState: AppState(),
                              reducer: appReducer,
                              environment: AppEnvironment(homeEnvironment: .init()))
            AppView(store: store)
        }

        #if os(macOS)
        windowGroup
            .windowToolbarStyle(UnifiedCompactWindowToolbarStyle(showsTitle: false))
        #endif

        windowGroup
    }
}
