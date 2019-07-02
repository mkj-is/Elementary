import XCTest
import Elementary

final class ElementaryTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(Elementary().text, "Hello, World!")
    }

    func testArrayStatePerformance() {
        struct Todo {
            let text = "Some todo"
        }

        enum TodoAction {
            case add(Todo)
        }

        let store = TestStore<[Todo], TodoAction>(state: []) { state, action in
            switch action {
            case .add(let todo):
                return state + [todo]
            }
        }

        measure {
            for _ in 0...1000 {
                store.dispatch(TodoAction.add(Todo()))()
            }
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
