import XCTest
import Elementary

final class CounterTests: XCTestCase {

    func testIncrement() {
        let store = counterStore()
        XCTAssertEqual(0, store.state)
        store.dispatch(.increment)
        XCTAssertEqual(1, store.state)
    }

    func testDecrement() {
        let store = counterStore(state: 5)
        XCTAssertEqual(5, store.state)
        store.dispatch(.decrement)
        XCTAssertEqual(4, store.state)
    }

    func testDecrementWhenZero() {
        let store = counterStore()
        XCTAssertEqual(0, store.state)
        store.dispatch(.decrement)
        XCTAssertEqual(0, store.state)
    }

    func testReset() {
        let store = counterStore(state: 5)
        XCTAssertEqual(5, store.state)
        store.dispatch(.reset)
        XCTAssertEqual(0, store.state)
    }

    func testActionSequence() {
        let store = counterStore()
        XCTAssertEqual(0, store.state)
        store.dispatch(.increment)
        XCTAssertEqual(1, store.state)
        store.dispatch(.increment)
        XCTAssertEqual(2, store.state)
        store.dispatch(.increment)
        XCTAssertEqual(3, store.state)
        store.dispatch(.decrement)
        XCTAssertEqual(2, store.state)
        store.dispatch(.increment)
        XCTAssertEqual(3, store.state)
        store.dispatch(.reset)
        XCTAssertEqual(0, store.state)
    }

    static var allTests = [
        ("testIncrement", testIncrement),
        ("testDecrement", testDecrement),
        ("testDecrementWhenZero", testDecrementWhenZero),
        ("testReset", testReset),
        ("testActionSequence", testActionSequence)
    ]
}
