import Vapor

public enum EmailAttachment {
    case attachment(Vapor.File)
    case inline(Vapor.File)
}

// MARK: Codable
extension EmailAttachment: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case file
    }
    
    enum AttachmentType: String, Codable {
        case attachment
        case inline
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(AttachmentType.self, forKey: .type)
        
        switch type {
        case .attachment:
            self = try .attachment(container.decode(File.self, forKey: .file))
        case .inline:
            self = try .inline(container.decode(File.self, forKey: .file))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case let .attachment(file):
            try container.encode(AttachmentType.attachment, forKey: .type)
            try container.encode(file, forKey: .file)
        case let .inline(file):
            try container.encode(AttachmentType.inline, forKey: .type)
            try container.encode(file, forKey: .file)
        }
    }
}
