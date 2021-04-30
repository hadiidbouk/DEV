//
//  NSView+Extensions.swift
//  DEV (macOS)
//
//  Created by Hadi on 27/04/2021.
//

import AppKit

extension NSView {
    func setBackgroundColor(_ color: NSColor) {
        setValue(color, forKey: "backgroundColor")
    }
}

extension NSSplitView {
    func setDividerColor(_ color: NSColor) {
        setValue(color, forKey: "dividerColor")
    }
}
