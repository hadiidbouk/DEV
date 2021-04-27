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

    var titlebarView: NSView? {
        titlebarContainerView?.subviews.first(where: \.isTitlebarView)
    }
}

private extension NSView {
    var isTitlebarContainerView: Bool {
        guard let `class` = NSClassFromString("NSTitlebarContainerView") else { return false }
        return isKind(of: `class`)
    }

    var isTitlebarView: Bool {
        guard let `class` = NSClassFromString("NSTitlebarView") else { return false }
        return isKind(of: `class`)
    }
}
