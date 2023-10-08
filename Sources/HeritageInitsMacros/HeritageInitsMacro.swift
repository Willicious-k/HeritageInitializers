
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct HeritageInitsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        InitFromDict.self
    ]
}

struct InitFromDict: MemberMacro {
    static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        <#code#>
    }

}
