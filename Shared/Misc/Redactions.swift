//
//  Redactions.swift
//  DEV
//
//  Created by Hadi on 19/04/2021.
//

import SwiftUI

enum RedactionReason {
    case placeholder
}

enum ShapeType {
    case roundedRectangle(cornerRadius: CGFloat)
    case circle
}

extension View {
    func redacted(_ isRedacted: Bool,
                  reason: RedactionReason = .placeholder,
                  shapeType: ShapeType = .roundedRectangle(cornerRadius: Layout.roundedRectCornerRadius)) -> AnyView {
        isRedacted ? modifier(Redactable(reason: reason, shapeType: shapeType)).anyView : self.anyView
    }
}

// MARK: - Private Section
private enum Layout {
    static let roundedRectCornerRadius: CGFloat = 12
    static let overlayVerticalPadding: CGFloat = 2
}

private struct Placeholder: ViewModifier {
    let shapeType: ShapeType

    func body(content: Content) -> some View {
        content
            .opacity(.zero)
            .overlay(
                overlayView
                    .padding(.vertical, Layout.overlayVerticalPadding)
            )
    }

    @ViewBuilder
    var overlayView: some View {
        switch shapeType {
        case let .roundedRectangle(cornerRadius):
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.appTertiary)
        case .circle:
            Circle()
                .fill(Color.appTertiary)
        }
    }
}

private struct Redactable: ViewModifier {
    let reason: RedactionReason
    let shapeType: ShapeType

    @ViewBuilder
    func body(content: Content) -> some View {
        switch reason {
        case .placeholder:
            content
                .modifier(Placeholder(shapeType: shapeType))
        }
    }
}
