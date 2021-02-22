public protocol EmailAddressRepresentable {
    var emailAddress: String { get }
    var emailName: String? { get }
}

extension EmailAddressRepresentable {
    static var nameKeyPath: KeyPath<Self, String>? {
        nil
    }
    
    var emailAddress: EmailAddress {
        if let name = self.emailName {
            return .init(email: self.emailAddress, name: name)
        } else {
            return .init(email: self.emailAddress)
        }
    }
}

