//
//  Redactions.swift
//  DEV
//
//  Created by Hadi on 19/04/2021.
//

import SwiftUI

extension RedactionReasons {
    public static let animatedPlaceholder = RedactionReasons(rawValue: 100)
}

enum ShapeType {
    case rectangle
    case roundedRectangle(cornerRadius: CGFloat)
    case circle
}

extension View {
    func redactable(shapeType: ShapeType = .roundedRectangle(cornerRadius: Layout.roundedRectCornerRadius)) -> some View {
        modifier(Redactable(shapeType: shapeType))
    }
}

// MARK: - Private Section
private enum Layout {
    static let roundedRectCornerRadius: CGFloat = 12
    static let overlayPadding: CGFloat = 2
    static let animationDuration: TimeInterval = 1
}

private struct AnimatedPlaceholder: ViewModifier {
    let shapeType: ShapeType
    @State var size: CGSize = .zero

    @State private var xOffset: CGFloat = .zero
    private let timer = Timer.publish(every: Layout.animationDuration, on: .main, in: .common).autoconnect()

    let gradient = Gradient(colors: [.appSecondary, .appTertiary, .appSecondary])

    func body(content: Content) -> some View {
        content
            .opacity(.zero)
            .overlay(overlayView)
            .onReceive(timer) { _ in
                if xOffset == size.width {
                    xOffset = -size.width
                } else {
                    withAnimation(.linear(duration: Layout.animationDuration)) {
                        xOffset = size.width
                    }
                }
            }
            .overlay(
                ZStack {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                size = geometry.size
                            }
                    }
                }
            )
    }

    @ViewBuilder
    var overlayView: some View {
        switch shapeType {
        case .rectangle:
            addAnimationContainer { Rectangle() }
        case let .roundedRectangle(cornerRadius):
            addAnimationContainer { RoundedRectangle(cornerRadius: cornerRadius) }
        case .circle:
            addAnimationContainer { Circle() }
        }
    }

    @ViewBuilder
    func addAnimationContainer<Content: Shape>(content: () -> Content) -> some View {
        ZStack {
            content()
                .fill(Color.appSecondary)

            Rectangle()
                .fill(LinearGradient(gradient: gradient,
                                     startPoint: .leading,
                                     endPoint: .trailing))
                .offset(x: xOffset)
        }
        .clipShape(content())
    }
}

private struct Redactable: ViewModifier {
    @Environment(\.redactionReasons) private var reasons

    let shapeType: ShapeType

    @ViewBuilder
    func body(content: Content) -> some View {
        switch reasons {
        case .animatedPlaceholder:
            content
                .modifier(AnimatedPlaceholder(shapeType: shapeType))
        default:
            content
        }
    }
}
