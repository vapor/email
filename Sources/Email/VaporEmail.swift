import Vapor

public struct VaporEmail: Content {
    public let from: EmailAddress
    public let to: [EmailAddress]
    public let replyTo: EmailAddress?
    public let cc: [EmailAddress]?
    public let bcc: [EmailAddress]?
    public let subject: String
    public let text: String
    public let html: String?
    // attachments
    // inline attachments
    
    public init(
        from: EmailAddress,
        to: [EmailAddress],
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        text: String,
        html: String? = nil
    ) {
        self.from = from
        self.to = to
        self.replyTo = replyTo
        self.cc = cc
        self.bcc = bcc
        self.subject = subject
        self.text = text
        self.html = html
    }
    
    public init(
        from: EmailAddress,
        to: EmailAddress,
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        text: String,
        html: String? = nil
    ) {
        self.init(from: from, to: [to], replyTo: replyTo, cc: cc, bcc: bcc, subject: subject, text: text, html: html)
    }
    
    public init<E>(
        from: EmailAddress,
        to: [E],
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        text: String,
        html: String? = nil
    )
        where E: Emailable
    {
        self.init(from: from,
                  to: to.map { $0.emailAddress },
                  replyTo: replyTo,
                  cc: cc,
                  bcc: bcc,
                  subject: subject,
                  text: text,
                  html: html
        )
    }
}
