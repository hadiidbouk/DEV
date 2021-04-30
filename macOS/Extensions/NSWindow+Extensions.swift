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

    var splitView: NSSplitView? {
        contentView?.findViews(subclassOf: NSSplitView.self).first
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

private extension NSView {
    func findViews<T: NSView>(subclassOf: T.Type) -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }

    var recursiveSubviews: [NSView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }
}
