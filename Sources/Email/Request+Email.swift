import Vapor

extension Request {
    var email: EmailClient {
        application.email.delegating(to: eventLoop)
    }
}
