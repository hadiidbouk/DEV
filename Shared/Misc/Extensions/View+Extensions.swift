//
//  View+Extensions.swift
//  Shared
//
//  Created by Hadi on 24/03/2021.
//

import SwiftUI

extension View {
    func on<Content: View>(_ platforms: Platform..., transform: (Self) -> Content) -> AnyView {
        guard platforms.contains(Platform.current) else { return anyView }
        return transform(self).anyView
    }

    var anyView: AnyView { AnyView(self) }

    func rectReader(_ binding: Binding<CGRect>, in coordinatorSpace: CoordinateSpace = .local) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: coordinatorSpace)
            DispatchQueue.main.async {
                binding.wrappedValue = rect
            }
            return .clear
        }
    }

    func applyBackground(_ color: Color = .background) -> some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)
            self
        }
    }

    func applyBorder(cornerRadius: CGFloat = 5,
                     color: Color = .border,
                     lineWidth: CGFloat = 1) -> some View {
        self
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: lineWidth)
        )
    }
}
