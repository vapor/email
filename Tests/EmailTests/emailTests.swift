import XCTest
@testable import email

final class emailTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(email().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
