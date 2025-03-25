//
//  GreenDirectoryApp.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import SwiftUI

@main
struct GreenDirectoryApp: App {
    var body: some Scene {
        @AppStorage("isFirstTimeLaunch") var isFirstTimeLaunch: Bool = true

        WindowGroup {
            ContentView()
        }
        .modelContainer(Container.create(shouldCreateDefaults: &isFirstTimeLaunch))
    }
}
