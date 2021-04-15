//
//  RoundedBorderViewModifier.swift
//  DEV
//
//  Created by Hadi on 08/04/2021.
//

import SwiftUI

private enum Layout {
    static let defaultBorderWidth: CGFloat = 3
}

struct RoundedBorderViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .stroke(Color.border, lineWidth: Layout.defaultBorderWidth)
            )
            .clipShape(Circle())
    }
}

extension View {
    func roundedBorder(borderWidth: CGFloat = Layout.defaultBorderWidth) -> some View {
        modifier(RoundedBorderViewModifier())
    }
}
