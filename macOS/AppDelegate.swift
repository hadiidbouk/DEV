//
//  AppDelegate.swift
//  DEV (macOS)
//
//  Created by Hadi on 04/04/2021.
//

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let mainWindow = NSApplication.shared.windows.first else { return }
        mainWindow.titlebarAppearsTransparent = true
        mainWindow.backgroundColor = NSColor(.background)
        mainWindow.titlebarView?.setBackgroundColor(NSColor(.background))
        mainWindow.splitView?.setDividerColor(.clear)
    }
}
