//
//  ContentView.swift
//  Shared
//
//  Created by Hadi on 22/03/2021.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
#endif
