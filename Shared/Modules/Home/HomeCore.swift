//
//  HomeCore.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import ComposableArchitecture
import DEVAPI

enum Constants {
    static let loadLatestArticlesCancellableId = UUID()
}
struct HomeState: Equatable {
    var queryItems: [DEVQueryItem] = []
    var articles: [Article] = (0..<4).map { _ in Article.mock() }
    var error: AppError?
    var isLoading: Bool = false
}

enum HomeAction {
    case loadLatestArticles
    case loadLatestArticlesResponse(Result<[Article], AppError>)
    case none
}

struct HomeEnvironment {
    let articles: DEVClient.Articles
}

let homeReducer = Reducer<HomeState, HomeAction, HomeEnvironment> { state, action, environment in
    switch action {
    case .loadLatestArticles:
        state.isLoading = true
        return environment.articles.all(state.queryItems)
            .receive(on: DispatchQueue.main.eraseToAnyScheduler())
            .mapError(AppError.map)
            .catchToEffect()
            .map(HomeAction.loadLatestArticlesResponse)
            .cancellable(id: Constants.loadLatestArticlesCancellableId)

    case let .loadLatestArticlesResponse(.success(articles)):
        state.articles = articles

        if articles.first?.coverImage == nil,
           let index = articles.firstIndex(where: { !$0.coverImage.isNilOrEmpty }) {
            let article = state.articles.remove(at: index)
            state.articles.insert(article, at: 0)
        }

        state.isLoading = false
        return .none
    case let .loadLatestArticlesResponse(.failure(error)):
        state.error = error
        state.isLoading = true
        return .none
    case .none:
        return .none
    }
}
