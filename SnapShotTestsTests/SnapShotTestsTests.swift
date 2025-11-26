//
//  SnapShotTestsTests.swift
//  SnapShotTestsTests
//
//  Created by Kostiantyn Kolontai on 2025-11-25.
//
import UIKit
import XCTest
@testable import SnapShotTests
import SnapshotTesting
import SwiftUI

// MARK: - Snapshot Tests
class SnapShotTestsTests: XCTestCase {

  override func invokeTest() {
    withSnapshotTesting(record: .failed) {
      super.invokeTest()
    }
  }

  @MainActor
  func testSnapshot_mainContent_iPhone13() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhone13)))
  }

  @MainActor
  func testSnapshot_withSheet_iPhone13() {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let hostingController = UIHostingController(rootView: viewS)
    let navController = UINavigationController(rootViewController: hostingController)

    // Create a window for testing - use scene if available, otherwise frame
    let window: UIWindow
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      window = UIWindow(windowScene: windowScene)
    } else {
      // Fallback for test environment where no scene exists
      window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844)) // iPhone 13 size
    }

    window.rootViewController = navController
    window.makeKeyAndVisible()

    // Force initial layout
    navController.view.setNeedsLayout()
    navController.view.layoutIfNeeded()

    // Wait for sheet presentation to complete
    let expectation = XCTestExpectation(description: "Wait for sheet presentation")
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)

    // Snapshot the navigation controller with presented sheet
    assertSnapshot(of: navController, as: .image(on: .iPhone13, traits: .init(userInterfaceStyle: .light)))

    window.isHidden = true
  }

  @MainActor
  func testSnapshot_sheetContent_iPhone13() {
    let vm = ViewStore()
    let sheetView = SheetContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView: sheetView))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhone13)))
  }

  @MainActor
  func testSnapshot_mainContent_iPhoneSE() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhoneSe)))
  }

  @MainActor
  func testSnapshot_withSheet_iPhoneSE() {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let hostingController = UIHostingController(rootView: viewS)
    let navController = UINavigationController(rootViewController: hostingController)

    let window: UIWindow
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      window = UIWindow(windowScene: windowScene)
    } else {
      window = UIWindow(frame: CGRect(x: 0, y: 0, width: 375, height: 667)) // iPhone SE size
    }

    window.rootViewController = navController
    window.makeKeyAndVisible()

    navController.view.setNeedsLayout()
    navController.view.layoutIfNeeded()

    let expectation = XCTestExpectation(description: "Wait for sheet presentation")
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)

    assertSnapshot(of: navController, as: .image(on: .iPhoneSe, traits: .init(userInterfaceStyle: .light)))

    window.isHidden = true
  }

  @MainActor
  func testSnapshot_sheetContent_iPhoneSE() {
    let vm = ViewStore()
    let sheetView = SheetContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView: sheetView))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhoneSe)))
  }

  @MainActor
  func testSnapshot_mainContent_iPadMini() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPadMini(.portrait))))
  }

  @MainActor
  func testSnapshot_withSheet_iPadMini() {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let hostingController = UIHostingController(rootView: viewS)
    let navController = UINavigationController(rootViewController: hostingController)

    let window: UIWindow
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      window = UIWindow(windowScene: windowScene)
    } else {
      window = UIWindow(frame: CGRect(x: 0, y: 0, width: 768, height: 1024)) // iPad Mini size
    }

    window.rootViewController = navController
    window.makeKeyAndVisible()

    navController.view.setNeedsLayout()
    navController.view.layoutIfNeeded()

    let expectation = XCTestExpectation(description: "Wait for sheet presentation")
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)

    assertSnapshot(of: navController, as: .image(on: .iPadMini(.portrait), traits: .init(userInterfaceStyle: .light)))

    window.isHidden = true
  }

  @MainActor
  func testSnapshot_sheetContent_iPadMini() {
    let vm = ViewStore()
    let sheetView = SheetContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView: sheetView))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPadMini(.portrait))))
  }
}
