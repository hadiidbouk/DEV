//
//  View+Extensions.swift
//  Shared
//
//  Created by Hadi on 24/03/2021.
//

import SwiftUI

extension View {
    @ViewBuilder func only(on platform: Platform) -> some View {
        switch platform {
        case .iOS:
            #if os(iOS)
                self
            #else
                EmptyView()
            #endif
        case .macOS:
            #if os(macOS)
                self
            #else
                EmptyView()
            #endif
        }
    }
}
