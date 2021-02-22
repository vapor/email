import Vapor

extension Application {
    public struct Emails {
        public struct Provider {
            let run: (Application) -> ()
            
            public init(_ run: @escaping (Application) -> ()) {
                self.run = run
            }
        }
        
        let application: Application
        
        final class Storage {
            var makeEmailClient: ((Application) -> EmailClient)?
            public init() { }
        }
        
        struct Key: StorageKey {
            typealias Value = Storage
        }
        
        var storage: Storage {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }
            
            return self.application.storage[Key.self]!
        }
        
        func initialize() {
            self.application.storage[Key.self] = .init()
        }
        
        public func use(_ makeEmailClient: @escaping ((Application) -> EmailClient)) {
            self.storage.makeEmailClient = makeEmailClient
        }
        
        public func use(_ provider: Provider) {
            provider.run(application)
        }
        
        public var client: EmailClient {
            guard let factory = self.storage.makeEmailClient else {
                fatalError("EmailClient is not configured, use: app.emails.use()")
            }
            
            return factory(application)
        }
    }
    
    public var emails: Emails {
        .init(application: self)
    }
    
    public var email: EmailClient {
        emails.client
    }
}
