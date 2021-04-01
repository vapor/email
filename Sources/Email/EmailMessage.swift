import Vapor

public struct EmailMessage: Codable {
    public let from: EmailAddress
    public let to: [EmailAddress]
    public let replyTo: EmailAddress?
    public let cc: [EmailAddress]?
    public let bcc: [EmailAddress]?
    public let subject: String
    public let content: Content
    public let attachments: [EmailAttachment]?
    
    /// Intitialize new message with a single recipient.
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
    
    /// Intitialize new message with a single recipient conforming to `EmailAddressRepresentable`
    public init<E>(
        from: EmailAddress,
        to: E,
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
            to: [to],
            replyTo: replyTo,
            cc: cc,
            bcc: bcc,
            subject: subject,
            content: content,
            attachments: attachments
        )
    }
    
    /// Intitialize new message with multiple recipients conforming to `EmailAddressRepresentable`
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
    
    /// Intitialize new message a single recipient conforming to `EmailAddressRepresentable`
    public init<E>(
        from: String,
        to: E,
        replyTo: String? = nil,
        cc: [String]? = nil,
        bcc: [String]? = nil,
        subject: String,
        content: Content,
        attachments: [EmailAttachment]? = nil
    )
        where E: EmailAddressRepresentable
    {
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
    
    /// Intitialize new message with multiple recipients conforming to `EmailAddressRepresentable`
    public init<E>(
        from: String,
        to: [E],
        replyTo: String? = nil,
        cc: [String]? = nil,
        bcc: [String]? = nil,
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
        from: String,
        to: String,
        replyTo: String? = nil,
        cc: [String]? = nil,
        bcc: [String]? = nil,
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
    
    public init(
        from: String,
        to: [String],
        replyTo: String? = nil,
        cc: [String]? = nil,
        bcc: [String]? = nil,
        subject: String,
        content: Content,
        attachments: [EmailAttachment]? = nil
    ) {
        self.init(
            from: EmailAddress(stringLiteral: from),
            to: to.map(EmailAddress.init),
            replyTo: replyTo.map(EmailAddress.init),
            cc: cc?.map(EmailAddress.init),
            bcc: bcc?.map(EmailAddress.init),
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
