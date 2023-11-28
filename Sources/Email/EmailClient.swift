import Vapor

public protocol EmailClient {
    func send(_ messages: [EmailMessage]) -> EventLoopFuture<Void>
    func delegating(to eventLoop: EventLoop) -> Self
}

extension EmailClient {
    public func send(_ message: EmailMessage) -> EventLoopFuture<Void> {
        self.send([message])
    }
}