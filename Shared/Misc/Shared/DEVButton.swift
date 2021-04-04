//
//  DEVButton.swift
//  DEV
//
//  Created by Hadi on 03/04/2021.
//

import SwiftUI

struct DEVButtonConfig {
    var cornerRadius: CGFloat = 5
    var forgroundColor: Color = .primaryText
    var selectedForgroundColor: Color = .primaryText
    var backgroundColor: Color = .clear
    var selectedBackgroundColor: Color = .clear
    var textFont: Font = .body
    var imageSize: CGFloat = 20
    var contentPadding: CGFloat = 6
    var clickable = true

    var isFrameInvisible: Bool {
        backgroundColor == .clear && selectedBackgroundColor == .clear
    }
}

struct DEVButton: View {
    @State var didHover: Bool = false

    let title: String
    let imageName: String
    let config: DEVButtonConfig
    let action: () -> Void

    init(_ title: String = "",
         imageName: String = "",
         config: (inout DEVButtonConfig) -> Void = { _ in },
         action: @escaping () -> Void = {}) {
        self.title = title
        self.imageName = imageName
        self.action = action

        var mutableConfig = DEVButtonConfig()
        config(&mutableConfig)
        self.config = mutableConfig
    }

    var body: some View {
        Button(action: action) {
            let label = Label(
                title: {
                    Text(title)
                        .font(config.textFont)
                },
                icon: {
                    Image(imageName)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: config.imageSize, height: config.imageSize)
                }
            )

            if title.isEmpty && imageName.isEmpty {
                EmptyView()
            } else if imageName.isEmpty {
                label
                    .labelStyle(TitleOnlyLabelStyle())
            } else if title.isEmpty {
                label
                    .labelStyle(IconOnlyLabelStyle())
            } else {
                label
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: config.cornerRadius))
        .onHover { inside in
            didHover = inside

            guard config.clickable else { return }

            #if os(macOS)
            // This is a workaround, I found an unexpected behavior when I want to update the cursor,
            // it seems that multiple of events are passed to changeCursor function and the NSCursor stack
            // are not set correctly.
            // if we use onChange function we will see a warning in the console:
            // "onChange(of: Bool) action tried to update multiple times per frame."
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                changeCursor(to: .pointingHand, inside)
            }
            #endif
        }
        .buttonStyle(Style(config, didHover: $didHover))
    }
}

private struct Style: ButtonStyle {
    let config: DEVButtonConfig
    @Binding var didHover: Bool

    init(_ config: DEVButtonConfig, didHover: Binding<Bool>) {
        self.config = config
        self._didHover = didHover
    }

    func makeBody(configuration: Configuration) -> some View {
        let actionHappened = (configuration.isPressed || didHover) && config.clickable
        return configuration.label
            .padding(config.isFrameInvisible ? .zero : config.contentPadding)
            .foregroundColor(actionHappened ? config.selectedForgroundColor : config.forgroundColor)
            .background(actionHappened ? config.selectedBackgroundColor : config.backgroundColor)
    }
}

#if DEBUG
struct DEVButton_Previews: PreviewProvider {
    static var previews: some View {
        DEVButton("Click Me",
                  imageName: "comments",
                  config: {
                    $0.selectedBackgroundColor = .red
                  },
                  action: {
                    print("Clicked")
                  })
    }
}
#endif
