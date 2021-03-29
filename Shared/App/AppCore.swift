//
//  AppCore.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import ComposableArchitecture
import SwiftUI

struct AppState: Equatable {
    var home = HomeState()

    var selectedModule: Module = .home
}

enum AppAction {
    case home(HomeAction)

    case moduleDidSelected(_ module: Module)
    case toggleSideBar
    case onSideBarButtonHover(_ inside: Bool)
}

struct AppEnvironment {
    let homeEnvironment: HomeEnvironment
}

let appReducer = Reducer.combine(
    Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
        switch action {
        case .home:
            return .none
        case let .moduleDidSelected(module):
            guard state.selectedModule != module else { return .none }
            state.selectedModule = module
            return .none
        case .toggleSideBar:
            #if os(macOS)
            let firstResponder = NSApp.keyWindow?.firstResponder
            firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
            #endif
            return .none
        case let .onSideBarButtonHover(inside):
            #if os(macOS)
            changeCursor(to: NSCursor.pointingHand, inside)
            #endif
            return .none
        }
    },

    homeReducer.pullback(state: \.home,
                         action: /AppAction.home,
                         environment: \.homeEnvironment)
)
