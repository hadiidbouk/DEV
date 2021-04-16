//
//  AppError.swift
//  DEV
//
//  Created by Hadi on 08/04/2021.
//

import Foundation

enum AppError: Error {
    case url(URLError?)
    case decode(Error)
    case unknown(Error)
}

extension AppError {
    static func map(_ error: Error) -> AppError {
        switch error {
        case is DecodingError: return AppError.decode(error)
        case is URLError: return AppError.url(error as? URLError)
        default: return AppError.unknown(error)
        }
    }
}

extension AppError: Equatable {
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case let (.url(lhsUrlError), .url(rhsUrlError)):
            return lhsUrlError == rhsUrlError
        case (.decode, .decode):
            return true
        case let (.unknown(lhsError), .unknown(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
