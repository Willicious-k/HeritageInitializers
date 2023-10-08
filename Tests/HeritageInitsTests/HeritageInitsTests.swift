
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import HeritageInitsMacros

let testMacros: [String: Macro.Type] = [
    "InitFromDict": InitFromDictMacro.self
]

final class HeritageInitsTests: XCTestCase {
    func testInitFromDictMacro() throws {
        assertMacroExpansion(
            """
            @InitFromDict
            struct Payload {
                let title: String
                let message: String?
                let nextYear: Int
                let willStart: Bool
            }
            """,
            expandedSource:
            """

            struct Payload {
                let title: String
                let message: String?
                let nextYear: Int
                let willStart: Bool
            }
            """,
            macros: testMacros
        )
    }
}
