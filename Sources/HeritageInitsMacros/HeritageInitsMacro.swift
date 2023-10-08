
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
        let memberList = declaration.memberBlock.members
        let memberBindingList = memberList.compactMap {
            $0.decl.as(VariableDeclSyntax.self)?.bindings.first
        }

        let conditionStmts = memberBindingList.compactMap { binding -> String? in
            let typeToken = binding.typeAnnotation?.as(TypeAnnotationSyntax.self)

            guard
                let typed = typeToken?.type.as(IdentifierTypeSyntax.self),
                let nameToken = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text
            else {
                return nil
            }
            let typeText = typed.name.text
            return "let \(nameToken) = dict[\"\(nameToken)\"] as? \(typeText)"
        }

        let assignmentStmts = memberBindingList.compactMap { binding -> String? in
            let typeToken = binding.typeAnnotation?.as(TypeAnnotationSyntax.self)

            guard
                let nameToken = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text
            else {
                return nil
            }

            var assignmentText = ""
            if let typed = typeToken?.type.as(IdentifierTypeSyntax.self) {
                assignmentText = "\(nameToken)"
            } else if let optionalTyped = typeToken?.type.as(OptionalTypeSyntax.self) {
                let optionalType = optionalTyped.wrappedType.as(IdentifierTypeSyntax.self)?.name.text
                assignmentText = "dict[\"\(nameToken)\"] as? \(optionalType!)"
            }
            return "self.\(nameToken) = \(assignmentText)"
        }

        let result: DeclSyntax =
        """
        init?(from dict: [String: Any]) {
            guard
            \(raw: conditionStmts.joined(separator: ",\n"))
            else {
                return nil
            }
            \(raw: assignmentStmts.joined(separator: "\n"))
        }
        """
        return [result]
    }
}

@main
struct HeritageInitsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        InitFromDictMacro.self
    ]
}
