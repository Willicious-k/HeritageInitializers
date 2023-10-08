
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct HeritageInitsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        InitFromDictMacro.self
    ]
}
