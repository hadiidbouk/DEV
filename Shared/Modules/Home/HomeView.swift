//
//  HomeView.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import ComposableArchitecture
import SwiftUI

private enum Layout {
    static let articlePadding: CGFloat = Platform.is(.macOS) ? 0 : 20
    static let articlesStackSpacing: CGFloat = 20
}

struct HomeView: View {
    let store: Store<HomeState, HomeAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                HStack(alignment: .top, spacing: .zero) {
                    LazyVStack(spacing: Layout.articlesStackSpacing) {
                        ForEach(viewStore.articles, id: \.self) { article in
                            ArticleView(article: article,
                                        isRedacted: viewStore.binding(get: \.isLoading,
                                                                      send: HomeAction.none))
                        }
                    }

                    // TODO: Replace this with real content
                    #if os(macOS)
                    LazyVStack(spacing: 15) {
                        ForEach(0..<30, id: \.self) { _ in
                            Color.appTertiary
                                .padding()
                        }
                        .frame(height: 150)
                    }
                    .frame(minWidth: .zero, maxWidth: 300)
                    #endif
                }
                .listRowBackground(Color.background)
                .listRowInsets(.zero)
            }
            .listStyle(PlainListStyle())
            .padding(Layout.articlePadding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear { viewStore.send(.loadLatestArticles) }
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: .init(initialState: .init(),
                              reducer: homeReducer,
                              environment: .init(articles: .mock)))
    }
}
#endif
