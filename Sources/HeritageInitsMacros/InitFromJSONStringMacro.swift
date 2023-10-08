
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct InitFromJSONStringMacro {}

extension InitFromJSONStringMacro: MemberMacro {
    static public func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let memberList = declaration.memberBlock.members

        let storedMemberBindingList = memberList
            .compactMap {
                $0.decl.as(VariableDeclSyntax.self)?.bindings.first
            }
            .filter {
                $0.accessorBlock == nil
            }

        guard
            // TODO: 초기값이 있는 저장프로퍼티는 어떻게 처리 할까요?
            // TODO: var 저장 프로퍼티는 어떻게 할까요?
            storedMemberBindingList.isEmpty == false,
            let typeDeclSyntax = declaration.as(StructDeclSyntax.self)
        else {
            return []
        }
        let typeName = typeDeclSyntax.name.text

        let result: DeclSyntax = 
        """
        init?(from jsonString: String) {
            guard
            let data = jsonString.data(using: .utf8),
            let result = try? JSONDecoder().decode(\(raw: typeName).self, from: data)
            else {
                return nil
            }
            self = result
        }
        """
        return [result]
    }
}

extension InitFromJSONStringMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        return [try ExtensionDeclSyntax("extension \(type): Decodable {}")]
    }
}
