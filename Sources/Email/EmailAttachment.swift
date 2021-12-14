import Vapor

public enum EmailAttachment: Codable, Equatable {
    case attachment(Vapor.File)
    case inline(Vapor.File)
}
