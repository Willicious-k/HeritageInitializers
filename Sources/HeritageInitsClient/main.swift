
import Foundation
import HeritageInits

@InitFromDict
struct Payload {
    let title: String
    let message: String?
    let nextYear: Int
    let willStart: Bool
    var computed: String {
        return "hello"
    }
}

@InitFromDict
final class ReferencePayload {
    let title: String
    let message: String?
    let nextYear: Int
    let willStart: Bool
    var computed: String {
        return "hello"
    }
}

@InitFromJSONString
struct AnotherPayload {
    let title: String
    let message: String?
    let nextYear: Int
    let willStart: Bool
    var computed: String {
        return "hello"
    }
}
