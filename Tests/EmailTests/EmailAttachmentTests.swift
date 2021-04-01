import Foundation
import XCTest
import Vapor
@testable import Email

final class EmailAttachmentTests: XCTestCase {
    var encoder: JSONEncoder!
    var decoder: JSONDecoder!
    
    override func setUpWithError() throws {
        encoder = JSONEncoder()
        decoder = JSONDecoder()
    }
    
    func test_attachment_codable() throws {
        let file = File(data: "123", filename: "file.txt")
        let sut = EmailAttachment.attachment(file)
        
        let data = try encoder.encode(sut)
        let decoded = try decoder.decode(EmailAttachment.self, from: data)
        
        guard case let .attachment(decodedFile) = decoded else {
            XCTFail("Decoded type was not `attachment`")
            return
        }
        
        XCTAssertEqual(decodedFile, file)
    }
    
    func test_inline_codable() throws {
        let file = File(data: "123", filename: "file.txt")
        let sut = EmailAttachment.inline(file)
        
        let data = try encoder.encode(sut)
        let decoded = try decoder.decode(EmailAttachment.self, from: data)
        
        guard case let .inline(decodedFile) = decoded else {
            XCTFail("Decoded type was not `inline`")
            return
        }
        
        XCTAssertEqual(decodedFile, file)
    }
}
