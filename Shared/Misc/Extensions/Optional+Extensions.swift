//
//  Optional+Extensions.swift
//  DEV
//
//  Created by Hadi on 02/05/2021.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
