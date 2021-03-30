import Vapor

extension Request {
    public var email: EmailClient {
        application.email.delegating(to: eventLoop)
    }
}
