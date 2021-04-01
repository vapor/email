import Foundation
import XCTest
import Vapor
@testable import Email

final class EmailMessageContentTests: XCTestCase {
    var encoder: JSONEncoder!
    var decoder: JSONDecoder!
    
    override func setUpWithError() throws {
        encoder = JSONEncoder()
        decoder = JSONDecoder()
    }
    
    func test_text_codable() throws {
        let sut = EmailMessage.Content.text("my text")
        
        let data = try encoder.encode(sut)
        let decoded = try decoder.decode(EmailMessage.Content.self, from: data)
        
        guard case let .text(text) = decoded else {
            XCTFail("Decoded type was not `text`")
            return
        }
        
        XCTAssertEqual(text, "my text")
    }
    
    func test_html_codable() throws {
        let sut = EmailMessage.Content.html("my html")
        
        let data = try encoder.encode(sut)
        let decoded = try decoder.decode(EmailMessage.Content.self, from: data)
        
        guard case let .html(html) = decoded else {
            XCTFail("Decoded type was not `html`")
            return
        }
        
        XCTAssertEqual(html, "my html")
    }
    
    func test_universal_codable() throws {
        let sut = EmailMessage.Content.universal(text: "my text", html: "my html")
        
        let data = try encoder.encode(sut)
        let decoded = try decoder.decode(EmailMessage.Content.self, from: data)
        
        guard case let .universal(text, html) = decoded else {
            XCTFail("Decoded type was not `universal`")
            return
        }
        
        XCTAssertEqual(text, "my text")
        XCTAssertEqual(html, "my html")
    }
}
