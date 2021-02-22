public protocol EmailAddressRepresentable {
    var email: String { get }
    var name: String? { get }
}

extension EmailAddressRepresentable {
    public var emailAddress: EmailAddress {
        if let name = self.name {
            return .init(email: self.email, name: name)
        } else {
            return .init(email: self.email)
        }
    }
}

