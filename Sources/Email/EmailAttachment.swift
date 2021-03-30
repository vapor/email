import Vapor

public enum EmailAttachment {
    case attachment(Vapor.File)
    case inline(Vapor.File)
}
