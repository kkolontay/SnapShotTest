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

class SnapShotTestsTests: XCTestCase {

  override func invokeTest() {
      withSnapshotTesting(record: .failed) {
        super.invokeTest()
      }
    }

  @MainActor
  func testexample() {
    let vm = ViewStore()
    let viewS = ContentView(viewModel: vm)
    let view = UINavigationController(rootViewController: UIHostingController(rootView:viewS))
    vm.show = true

    assertSnapshot(of: view, as: .wait(for: 0.3, on: .image(on: .iPhone13)))
    //        assertSnapshot(of: view, as: .recursiveDescription)
    //        assertSnapshot(of: view, as: .image(on: .iPhoneSe))
    //        assertSnapshot(of: view, as: .recursiveDescription(on: .iPhoneSe))
    //        //
    //        assertSnapshot(of: view, as: .image(on: .iPhoneSe(.landscape)))
    //        assertSnapshot(of: view, as: .recursiveDescription(on: .iPhoneSe(.landscape)))
    //        //
    //        assertSnapshot(of: view, as: .image(on: .iPhoneX))
    //        assertSnapshot(of: view, as: .recursiveDescription(on: .iPhoneX))
    //        //
    //        assertSnapshot(of: view, as: .image(on: .iPadMini(.portrait)))
    //        assertSnapshot(of: view, as: .recursiveDescription(on: .iPadMini(.portrait)))}
  }
}
