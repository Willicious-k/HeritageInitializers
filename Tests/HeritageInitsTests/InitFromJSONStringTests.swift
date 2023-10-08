
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import HeritageInitsMacros

final class InitFromJSONStringTests: XCTestCase {
    func testInitFromJSONStringMacro() throws {
        assertMacroExpansion(
            """
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
            """,
            expandedSource:
            """

            struct AnotherPayload {
                let title: String
                let message: String?
                let nextYear: Int
                let willStart: Bool
                var computed: String {
                    return "hello"
                }

                init?(from jsonString: String) {
                    guard
                    let data = jsonString.data(using: .utf8),
                    let result = try? JSONDecoder().decode(AnotherPayload.self, from: data)
                    else {
                        return nil
                    }
                    self = result
                }
            }

            extension AnotherPayload: Decodable {
            }
            """,
            macros: sut
        )
    }
}
