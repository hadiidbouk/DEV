//
//  AppDelegate.swift
//  DEV (macOS)
//
//  Created by Hadi on 04/04/2021.
//

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let windows = NSApplication.shared.windows
        windows.forEach { window in
            window.titlebarAppearsTransparent = true
            window.backgroundColor = NSColor(.background)
        }
    }
}
