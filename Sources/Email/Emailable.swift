// Perhaps protocol "Emailable" could be added to content that has a email field and optional name field?
public protocol Emailable {
    static var emailKeyPath: KeyPath<Self, String> { get }
    static var nameKeyPath: KeyPath<Self, String?>? { get }
}

extension Emailable {
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

