//
//  TextButton.swift
//  DEV
//
//  Created by Hadi on 01/04/2021.
//

import SwiftUI

struct TextButton: View {
    @State var didHover: Bool = false

    let text: String
    let textColor: Color
    let selectedTextColor: Color
    let action: () -> Void

    init(text: String,
         textColor: Color = .primaryText,
         selectedTextColor: Color = .accent,
         action: @escaping () -> Void) {
        self.text = text
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.action = action
    }

    var body: some View {
        Button(text, action: action)
            .buttonStyle(Style(textColor: textColor, selectedTextColor: selectedTextColor, didHover: $didHover))
            .onHover { inside in
                didHover = inside

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
    }
}

private struct Style: ButtonStyle {
    let textColor: Color
    let selectedTextColor: Color
    @Binding var didHover: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed || didHover ? selectedTextColor : textColor)
    }
}

#if DEBUG
struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(text: "Press Me!") {
            print("Pressed.")
        }
    }
}
#endif
