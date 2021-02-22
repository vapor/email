public protocol EmailAddressRepresentable {
    static var emailKeyPath: KeyPath<Self, String> { get }
    static var nameKeyPath: KeyPath<Self, String?>? { get }
}

extension EmailAddressRepresentable {
    static var nameKeyPath: KeyPath<Self, String>? {
        nil
    }
    
    var emailAddress: EmailAddress {
        if let nameKeyPath = Self.nameKeyPath {
            return .init(email: self[keyPath: Self.emailKeyPath], name: self[keyPath: nameKeyPath])
        } else {
            return .init(email: self[keyPath: Self.emailKeyPath])
        }
    }
}

