//
//  View+Extensions.swift
//  Shared
//
//  Created by Hadi on 24/03/2021.
//

import SwiftUI

extension View {
    @ViewBuilder func on<Content: View>(_ platform: Platform, transform: (Self) -> Content) -> some View {
        switch platform {
        case .iOS:
            #if os(iOS)
                transform(self)
            #else
                self
            #endif
        case .macOS:
            #if os(macOS)
                transform(self)
            #else
                self
            #endif
        }
    }
}

extension View {
    func applyBackground(_ color: Color = .background) -> some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)
            self
        }
    }

}
