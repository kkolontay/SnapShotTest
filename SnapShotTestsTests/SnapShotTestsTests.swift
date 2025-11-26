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

  // MARK: - Main Content Tests (Sheet Hidden)

  @MainActor
  func testSnapshot_mainContent_iPhone13() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

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
  func testSnapshot_mainContent_iPadMini() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPadMini(.portrait))))
  }

  // MARK: - Sheet Content Tests

  @MainActor
  func testSnapshot_sheetContent_iPhone13() {
    let vm = ViewStore()
    let sheetView = SheetContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView: sheetView))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhone13)))
  }

  @MainActor
  func testSnapshot_sheetContent_iPhoneSE() {
    let vm = ViewStore()
    let sheetView = SheetContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView: sheetView))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhoneSe)))
  }

  @MainActor
  func testSnapshot_sheetContent_iPadMini() {
    let vm = ViewStore()
    let sheetView = SheetContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView: sheetView))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPadMini(.portrait))))
  }
}
