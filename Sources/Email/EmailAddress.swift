import Vapor

public struct EmailAddress: Content {
    public let email: String
    public let name: String?
    
    public init(email: String, name: String? = nil) {
        self.email = email
        self.name = name
    }
}

extension EmailAddress: EmailAddressRepresentable {
    public static var emailKeyPath: KeyPath<EmailAddress, String> {
        \.email
    }
    
    public static var nameKeyPath: KeyPath<EmailAddress, String?>? {
        \.name
    }
}

extension EmailAddress: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        // "From: $Name <$Email>"
        let split = value.components(separatedBy: " <")
        guard let name = split.first else {
            self = .init(email: value)
            return
        }
        guard var emailPart = split.last else {
            self = .init(email: value)
            return
        }
        guard emailPart.removeLast() == ">" else {
            self = .init(email: value)
            return
        }
        
        self = .init(email: emailPart, name: name)
    }
}
