import Flutter
import UIKit
import XCTest

@testable import flutter_icon_dynamic

// This demonstrates a simple unit test of the Swift portion of this plugin's implementation.
//
// See https://developer.apple.com/documentation/xctest for more information about using XCTest.

class RunnerTests: XCTestCase {

  func testGetIsSupported() {
    let plugin = FlutterIconDynamicPlugin()

    let call = FlutterMethodCall(methodName: "isSupported", arguments: [])

    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      XCTAssertEqual(result as! Bool, UIApplication.shared.supportsAlternateIcons)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

}
