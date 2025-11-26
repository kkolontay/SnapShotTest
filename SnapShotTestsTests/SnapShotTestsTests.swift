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


  @MainActor
  func testSnapshot_initialState_iPhone13() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhone13)))
  }

  @MainActor
  func testSnapshot_sheetShown_iPhone13() {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhone13)))
  }

  @MainActor
  func testSnapshot_initialState_iPhoneSE() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhoneSe)))
  }

  @MainActor
  func testSnapshot_sheetShown_iPhoneSE() {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhoneSe)))
  }

  @MainActor
  func testSnapshot_initialState_iPadMini() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPadMini(.portrait))))
  }

  @MainActor
  func testSnapshot_sheetShown_iPadMini() {
    let vm = ViewStore()
    vm.show = true
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPadMini(.portrait))))
  }
}
