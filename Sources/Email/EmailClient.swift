import Vapor

public protocol EmailClient {
    func send(_ email: [VaporEmail]) -> EventLoopFuture<Void>
    func delegating(to eventLoop: EventLoop) -> EmailClient
}

extension EmailClient {
    public func send(_ email: VaporEmail) -> EventLoopFuture<Void> {
        self.send([email])
    }
}
