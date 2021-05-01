//
//  NSTableView+Extensions.swift
//  DEV (macOS)
//
//  Created by Hadi on 01/05/2021.
//

import SwiftUI

extension NSTableView {
  open override func viewDidMoveToWindow() {
    super.viewDidMoveToWindow()

    backgroundColor = NSColor.clear
    enclosingScrollView!.drawsBackground = false
  }
}
