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
  func testSnapshot_withSheet_iPhone13() async throws {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let hostingController = UIHostingController(rootView: viewS)
    let navController = UINavigationController(rootViewController: hostingController)

    // Create window - suppress iOS 26 deprecation warning
    let window: UIWindow
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      window = UIWindow(windowScene: windowScene)
    } else {
      if #available(iOS 26.0, *) {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
      } else {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
      }
    }

    window.rootViewController = navController
    window.makeKeyAndVisible()

    navController.view.setNeedsLayout()
    navController.view.layoutIfNeeded()

    // Wait for sheet presentation
    try await Task.sleep(nanoseconds: 800_000_000)

    // Verify sheet is presented
    XCTAssertNotNil(hostingController.presentedViewController, "Sheet should be presented")

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
  func testSnapshot_withSheet_iPhoneSE() async throws {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let hostingController = UIHostingController(rootView: viewS)
    let navController = UINavigationController(rootViewController: hostingController)

    let window: UIWindow
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      window = UIWindow(windowScene: windowScene)
    } else {
      if #available(iOS 26.0, *) {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
      } else {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
      }
    }

    window.rootViewController = navController
    window.makeKeyAndVisible()

    navController.view.setNeedsLayout()
    navController.view.layoutIfNeeded()

    try await Task.sleep(nanoseconds: 800_000_000)

    XCTAssertNotNil(hostingController.presentedViewController, "Sheet should be presented")

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
  func testSnapshot_withSheet_iPadMini() async throws {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let hostingController = UIHostingController(rootView: viewS)
    let navController = UINavigationController(rootViewController: hostingController)

    let window: UIWindow
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      window = UIWindow(windowScene: windowScene)
    } else {
      if #available(iOS 26.0, *) {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 768, height: 1024))
      } else {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 768, height: 1024))
      }
    }

    window.rootViewController = navController
    window.makeKeyAndVisible()

    navController.view.setNeedsLayout()
    navController.view.layoutIfNeeded()

    try await Task.sleep(nanoseconds: 800_000_000)

    XCTAssertNotNil(hostingController.presentedViewController, "Sheet should be presented")

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
