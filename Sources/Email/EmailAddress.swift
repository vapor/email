import Vapor

public struct EmailAddress: Content {
    public let email: String
    public let name: String?
    
    public init(email: String, name: String? = nil) {
        self.email = email
        self.name = name
    }
}

extension EmailAddress: Emailable {
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
        let regex = try? NSRegularExpression(pattern: #"([a-zA-Z\s]*) <([a-zA-Z@.]*)>$"#, options: .caseInsensitive)
        
        guard let match = regex?.firstMatch(in: value, options: [], range: .init(location: 0, length: value.utf16.count)) else {
            self = .init(email: value)
            return
        }
        
        guard let nameRange = Range(match.range(at: 1), in: value) else {
            self = .init(email: value)
            return
        }
        
        guard let emailRange = Range(match.range(at: 2), in: value) else {
                self = .init(email: value)
                return
        }
        
        let email = String(value[emailRange])
        let name = String(value[nameRange])
        
        self = EmailAddress(email: email, name: name)
    }
}
