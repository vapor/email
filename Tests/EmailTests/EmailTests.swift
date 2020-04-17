import XCTest
@testable import Email
import XCTVapor

final class EmailTests: XCTestCase {
    func testInitEmailAdressByString() throws {
        let emailAddressWithEmail: EmailAddress = "test@vapor.codes"
        XCTAssertEqual(emailAddressWithEmail.email, "test@vapor.codes")
        XCTAssertNil(emailAddressWithEmail.name)
        
        let emailAddressWithEmailAndName: EmailAddress = "Vapor <test@vapor.codes>"
        XCTAssertEqual(emailAddressWithEmailAndName.email, "test@vapor.codes")
        XCTAssertEqual(emailAddressWithEmailAndName.name, "Vapor")
        
        let emailAddressIncorrectFormat: EmailAddress = "name<test@vapor.codes>asd"
        XCTAssertEqual(emailAddressIncorrectFormat.email, "name<test@vapor.codes>asd")
    }
}
