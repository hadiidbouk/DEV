//
//  NSView+Extensions.swift
//  DEV (macOS)
//
//  Created by Hadi on 27/04/2021.
//

import AppKit

extension NSView {
    func addBackgroundColor(_ color: NSColor) {
        setValue(color, forKey: "backgroundColor")
    }
}
