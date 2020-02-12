import XCTest
import Elementary

final class StopwatchTests: XCTestCase {

    func testIncrement() {
        let store = stopwatchStore()
        XCTAssertEqual(0, store.state)
        store.dispatch(.increment)
        XCTAssertEqual(1, store.state)
    }

    func testReset() {
        let store = stopwatchStore(state: 5)
        XCTAssertEqual(5, store.state)
        store.dispatch(.reset)
        XCTAssertEqual(0, store.state)
    }

    func testStart() {
        let store = stopwatchStore()
        XCTAssertEqual(0, store.state)
        store.dispatch(.start)
        let expectation = self.expectation(description: "Stopwatch will increment after few seconds.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertLessThan(0, store.state)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testStop() {
        let store = stopwatchStore()
        XCTAssertEqual(0, store.state)
        store.dispatch(.start)
        store.dispatch(.stop)
        let expectation = self.expectation(description: "Stopwatch will not increment after stopping.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(0, store.state)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    static var allTests = [
        ("testIncrement", testIncrement),
        ("testReset", testReset),
        ("testStart", testStart),
        ("testStop", testStop),
    ]
}

