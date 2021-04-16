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
    var articles: [Article] = []
    var error: AppError?
}

enum HomeAction {
    case loadLatestArticles
    case loadLatestArticlesResponse(Result<[Article], AppError>)
}

struct HomeEnvironment {
    let articles: DEVClient.Articles
}

let homeReducer = Reducer<HomeState, HomeAction, HomeEnvironment> { state, action, environment in
    switch action {
    case .loadLatestArticles:
        return environment.articles.all(state.queryItems)
            .receive(on: DispatchQueue.main.eraseToAnyScheduler())
            .mapError(AppError.map)
            .catchToEffect()
            .map(HomeAction.loadLatestArticlesResponse)
            .cancellable(id: Constants.loadLatestArticlesCancellableId)

    case let .loadLatestArticlesResponse(.success(articles)):
        state.articles = articles
        return .none
    case let .loadLatestArticlesResponse(.failure(error)):
        state.error = error
        return .none
    }
}
