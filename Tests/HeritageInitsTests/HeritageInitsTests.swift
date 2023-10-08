
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(HeritageInitsMacros)
import HeritageInitsMacros

let testMacros: [String: Macro.Type] = [:]
#endif

final class HeritageInitsTests: XCTestCase {
    func testMacro() throws {
        #if canImport(HeritageInitsMacros)

        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testMacroWithStringLiteral() throws {
        #if canImport(HeritageInitsMacros)

        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
