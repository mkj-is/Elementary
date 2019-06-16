import XCTest

import ElementaryTests

var tests = [XCTestCaseEntry]()
tests += ElementaryTests.allTests()
XCTMain(tests)
