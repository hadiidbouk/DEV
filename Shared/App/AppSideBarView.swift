//
//  SideBarView.swift
//  DEV (macOS)
//
//  Created by Hadi on 24/03/2021.
//

import ComposableArchitecture
import SwiftUI

extension AppSideBarView {
    enum Layout {
        static let topPadding: CGFloat = 16
        static let selectedScale: CGFloat = 1.1
        static let defaultScale: CGFloat = 1
        static let labelHorizontalSpacing: CGFloat = 10
        static let buttonLeadingPadding: CGFloat = 10
    }
}

struct AppSideBarView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            #if os(macOS)
            sideBarView
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(
                            action: { viewStore.send(.toggleSideBar) },
                            label: {
                                Image(systemName: "sidebar.left")
                                    .foregroundColor(.accent)
                            })
                    }
                }
            #elseif os(iOS)
            sideBarView
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}

private extension AppSideBarView {
    var sideBarView: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                LazyVStack(spacing: Layout.buttonsSpacing) {
                    ForEach(Module.allCases) { module in
                        let isSelectedModule = viewStore.selectedModule == module
                        Button(
                            action: {
                                viewStore.send(.moduleDidSelected(module))
                            },
                            label: {
                                HStack {
                                    if isSelectedModule {
                                        Color.accent.frame(width: 3)
                                    }

                                    HStack(spacing: Layout.labelHorizontalSpacing) {
                                        Image(module.imageName)
                                            .resizable()
                                            .frame(width: Layout.imageSize, height: Layout.imageSize)
                                            .scaleEffect(isSelectedModule ? Layout.selectedScale :
                                                            Layout.defaultScale)
                                        Text(module.title)
                                            .font(.system(size: Layout.fontSize))
                                            .fontWeight(isSelectedModule ? .semibold: .regular)
                                            .foregroundColor(isSelectedModule ? .accent : .secondaryText)
                                    }

                                    Spacer()
                                }
                                .contentShape(Rectangle())
                            })
                            .buttonStyle(PlainButtonStyle())
                            .padding(.leading, isSelectedModule ? .zero : Layout.buttonLeadingPadding)
                            .onHover { viewStore.send(.onSideBarButtonHover($0)) }
                    }
                    Spacer()
                }
            }
            .padding(.top, Layout.topPadding)
            .applyBackground()
        }
    }
}

#if DEBUG
struct AppSideBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppSideBarView(store: .init(initialState: .init(),
                                    reducer: appReducer,
                                    environment: .init(homeEnvironment: .init(articles: .mock))))
    }
}
#endif
