
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct InitFromDictMacro: MemberMacro {
    static public func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        return []
    }
}

@main
struct HeritageInitsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        InitFromDictMacro.self
    ]
}
