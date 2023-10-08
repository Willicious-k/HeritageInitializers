
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import HeritageInitsMacros

final class InitFromDictTests: XCTestCase {
    func testInitFromDictMacro() throws {
        assertMacroExpansion(
            """
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
            """,
            expandedSource:
            """

            struct Payload {
                let title: String
                let message: String?
                let nextYear: Int
                let willStart: Bool
                var computed: String {
                    return "hello"
                }

                init?(from dict: [String: Any]) {
                    guard
                    let title = dict["title"] as? String,
                    let nextYear = dict["nextYear"] as? Int,
                    let willStart = dict["willStart"] as? Bool
                    else {
                        return nil
                    }
                    self.title = title
                    self.message = dict["message"] as? String
                    self.nextYear = nextYear
                    self.willStart = willStart
                }
            }
            """,
            macros: sut
        )
    }
}
