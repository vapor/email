import Vapor

public struct EmailMessage: Vapor.Content {
    public struct Content: Vapor.Content {
        public let html: String?
        public let text: String?
        
        public init(html: String, text: String? = nil) {
            self.html = html
            self.text = text
        }
        
        public init(html: String? = nil, text: String) {
            self.html = html
            self.text = text
        }
    }
    
    public let from: EmailAddress
    public let to: [EmailAddress]
    public let replyTo: EmailAddress?
    public let cc: [EmailAddress]?
    public let bcc: [EmailAddress]?
    public let subject: String
    public let content: Content
    // attachments
    // inline attachments
    
    public init(
        from: EmailAddress,
        to: [EmailAddress],
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        content: Content
    ) {
        self.from = from
        self.to = to
        self.replyTo = replyTo
        self.cc = cc
        self.bcc = bcc
        self.subject = subject
        self.content = content
    }
    
    public init(
        from: EmailAddress,
        to: EmailAddress,
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        content: Content
    ) {
        self.init(from: from, to: [to], replyTo: replyTo, cc: cc, bcc: bcc, subject: subject, content: content)
    }
    
    public init<E>(
        from: EmailAddress,
        to: [E],
        replyTo: EmailAddress? = nil,
        cc: [EmailAddress]? = nil,
        bcc: [EmailAddress]? = nil,
        subject: String,
        content: Content
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
            content: content)
    }
}
