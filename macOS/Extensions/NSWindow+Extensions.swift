//
//  NSWindow+Extensions.swift
//  DEV (macOS)
//
//  Created by Hadi on 19/04/2021.
//

import Cocoa

extension NSWindow {
    var titlebarContainerView: NSView? {
        contentView?.superview?.subviews.first(where: \.isTitlebarContainerView)
    }
}

private extension NSView {
    var isTitlebarContainerView: Bool {
        guard let `class` = NSClassFromString("NSTitlebarContainerView") else { return false }
        return isKind(of: `class`)
    }
}
