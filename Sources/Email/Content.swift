import Foundation

extension EmailMessage {
    public enum Content: Codable, Equatable {
        case text(String)
        case html(String)
        case universal(text: String, html: String)
    }
}
