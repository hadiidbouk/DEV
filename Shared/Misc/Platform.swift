//
//  Platform.swift
//  DEV
//
//  Created by Hadi on 24/03/2021.
//

import SwiftUI

enum Platform {
    case iOS
    case iPadOS
    case macOS

    static var current: Platform = {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .iOS
        } else {
            return .iPadOS
        }
        #else
        return .macOS
        #endif

    }()

    static func `is`(_ platform: Platform) -> Bool { current == platform }
}
