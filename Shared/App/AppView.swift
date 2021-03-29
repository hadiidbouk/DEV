//
//  ContentView.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    #endif

    let store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {

            #if os(iOS)
            if horizontalSizeClass == .compact {
                // iPhone
                Color.red
            } else {
                // iPad
                AppSideBarView(store: store)
            }
            #else
            AppSideBarView(store: store)
            #endif

            WithViewStore(store) { viewStore in
                viewStore.selectedModule.view(store)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: .init(initialState: .init(),
                             reducer: appReducer,
                             environment: .init(homeEnvironment: .init())))
    }
}
#endif
