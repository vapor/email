import Vapor

public struct EmailMessage {
    public enum Content {
        case text(String)
        case html(String)
        case universal(text: String, html: String)
    }
    
    public let from: EmailAddress
    public let to: [EmailAddress]
    public let replyTo: EmailAddress?
    public let cc: [EmailAddress]?
    public let bcc: [EmailAddress]?
    public let subject: String
    public let content: Content
    public let attachments: [EmailAttachment]?
    
    public init(
        from: EmailAddress,
        to: EmailAddress,
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        content: Content,
        attachments: [EmailAttachment]? = nil
    ) {
        self.init(
            from: from,
            to: [to],
            replyTo: replyTo,
            cc: cc,
            bcc: bcc,
            subject: subject,
            content: content,
            attachments: attachments
        )
    }
    
    public init<E>(
        from: EmailAddress,
        to: [E],
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        content: Content,
        attachments: [EmailAttachment]? = nil
    )
        where E: EmailAddressRepresentable
    {
        self.init(
            from: from,
            to: to.map { $0.emailAddress },
            replyTo: replyTo,
            cc: cc,
            bcc: bcc,
            subject: subject,
            content: content,
            attachments: attachments
        )
    }
    
    public init(
        from: EmailAddress,
        to: [EmailAddress],
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        content: Content,
        attachments: [EmailAttachment]? = nil
    ) {
        self.from = from
        self.to = to
        self.replyTo = replyTo
        self.cc = cc
        self.bcc = bcc
        self.subject = subject
        self.content = content
        self.attachments = attachments
    }
}
