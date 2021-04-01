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
        let moduleView = WithViewStore(store) { viewStore in
            let view = viewStore.selectedModule.view(store)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)

            #if os(iOS)
            view
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .applyBackground()
            #else
            view
            #endif
        }

        NavigationView {

            #if os(iOS)
            if horizontalSizeClass == .compact {
                // iPhone
                moduleView
            } else {
                // iPad
                AppSideBarView(store: store)
                moduleView
            }
            #else
            AppSideBarView(store: store)
            view
            #endif
        }
        .onAppear {
            #if os(iOS)
            let newAppearance = UINavigationBarAppearance()
            newAppearance.backgroundColor = UIColor(Color.background)
            UINavigationBar.appearance().standardAppearance = newAppearance
            #endif
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
