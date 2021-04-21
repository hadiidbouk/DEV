//
//  HomeView.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    let store: Store<HomeState, HomeAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                if viewStore.articles.isEmpty {
                    Text("Loading...")
                } else {
                    LazyVStack {
                        ForEach(viewStore.articles, id: \.self) { article in
                            ArticleView(article: article,
                                        isRedacted: viewStore.binding(get: \.isLoading,
                                                                      send: HomeAction.none))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
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
