import XCTest

import ElementaryTests

var tests = [XCTestCaseEntry]()
tests += CounterTests.allTests()
tests += StopwatchTests.allTests()
XCTMain(tests)
