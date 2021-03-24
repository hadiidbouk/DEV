//
//  DEVApp.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import SwiftUI

var config = AppConfig()

@main
struct DEVApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(config)
        }
    }
}
