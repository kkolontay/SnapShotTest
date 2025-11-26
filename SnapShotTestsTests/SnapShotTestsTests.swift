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

// MARK: - ViewStore Unit Tests
class ViewStoreTests: XCTestCase {

  func testViewStore_initialState() {
    let viewStore = ViewStore()
    XCTAssertFalse(viewStore.show, "ViewStore should initialize with show = false")
  }

  func testViewStore_toggleShowFromFalseToTrue() {
    let viewStore = ViewStore()
    viewStore.show = false

    viewStore.show.toggle()

    XCTAssertTrue(viewStore.show, "Toggling show from false should result in true")
  }

  func testViewStore_toggleShowFromTrueToFalse() {
    let viewStore = ViewStore()
    viewStore.show = true

    viewStore.show.toggle()

    XCTAssertFalse(viewStore.show, "Toggling show from true should result in false")
  }

  func testViewStore_setShowExplicitly() {
    let viewStore = ViewStore()

    viewStore.show = true
    XCTAssertTrue(viewStore.show)

    viewStore.show = false
    XCTAssertFalse(viewStore.show)
  }

  @MainActor
  func testViewStore_observableUpdates() {
    let viewStore = ViewStore()
    var updateCount = 0

    let expectation = expectation(description: "Observable should trigger updates")

    withObservationTracking {
      _ = viewStore.show
    } onChange: {
      updateCount += 1
      expectation.fulfill()
    }

    viewStore.show = true

    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(updateCount, 1, "Observable should trigger one update")
  }
}

// MARK: - ContentView Logic Tests
class ContentViewLogicTests: XCTestCase {

  @MainActor
  func testContentView_initialStateSheetHidden() {
    let viewStore = ViewStore()
    let contentView = ContentView(viewModel: viewStore)
    let hostingController = UIHostingController(rootView: contentView)

    XCTAssertFalse(viewStore.show, "Sheet should be hidden initially")
    XCTAssertNil(hostingController.presentedViewController, "No view controller should be presented initially")
  }

  @MainActor
  func testContentView_buttonActionTogglesShow() {
    let viewStore = ViewStore()
    XCTAssertFalse(viewStore.show, "Initial state should be false")

    // Simulate button action
    viewStore.show.toggle()

    XCTAssertTrue(viewStore.show, "Button action should toggle show to true")
  }

  @MainActor
  func testContentView_sheetDismissalTogglesShow() {
    let viewStore = ViewStore()
    viewStore.show = true
    XCTAssertTrue(viewStore.show, "Initial state should be true")

    // Simulate sheet button action
    viewStore.show.toggle()

    XCTAssertFalse(viewStore.show, "Sheet button action should toggle show to false")
  }

  @MainActor
  func testContentView_multipleToggleCycles() {
    let viewStore = ViewStore()

    XCTAssertFalse(viewStore.show, "Should start false")

    viewStore.show.toggle()
    XCTAssertTrue(viewStore.show, "First toggle should be true")

    viewStore.show.toggle()
    XCTAssertFalse(viewStore.show, "Second toggle should be false")

    viewStore.show.toggle()
    XCTAssertTrue(viewStore.show, "Third toggle should be true")
  }
}

// MARK: - Snapshot Tests
class SnapShotTestsTests: XCTestCase {

  override func invokeTest() {
      withSnapshotTesting(record: .failed) {
        super.invokeTest()
      }
    }

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
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))
    vm.show = true

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
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))
    vm.show = true

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
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))
    vm.show = true

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPadMini(.portrait))))
  }
}
