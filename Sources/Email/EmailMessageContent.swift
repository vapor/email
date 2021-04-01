import Foundation

extension EmailMessage {
    public enum Content {
        case text(String)
        case html(String)
        case universal(text: String, html: String)
    }
}

// MARK: Codable
extension EmailMessage.Content: Codable {
    enum CodingKeys: String, CodingKey {
        case text
        case html
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        switch try (container.decodeIfPresent(String.self, forKey: .text), try container.decodeIfPresent(String.self, forKey: .html)) {
        case let (.some(text), .some(html)):
            self = .universal(text: text, html: html)
        case let (.some(text), .none):
            self = .text(text)
        case let (.none, .some(html)):
            self = .html(html)
        case (.none, .none):
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Content must contain either text, html or both."))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case let .text(text):
            try container.encode(text, forKey: .text)
        case let .html(html):
            try container.encode(html, forKey: .html)
        case let .universal(text, html):
            try container.encode(text, forKey: .text)
            try container.encode(html, forKey: .html)
        }
    }
}
