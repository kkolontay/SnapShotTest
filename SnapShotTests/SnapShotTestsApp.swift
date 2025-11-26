//
//  SnapShotTestsApp.swift
//  SnapShotTests
//
//  Created by Kostiantyn Kolontai on 2025-11-25.
//

import SwiftUI

@main
struct SnapShotTestsApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(viewModel: ViewStore())
        }
    }
}
