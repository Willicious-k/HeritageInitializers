
import SwiftSyntaxMacros
import HeritageInitsMacros

let sut: [String: Macro.Type] = [
    "InitFromDict": InitFromDictMacro.self,
    "InitFromJSONString": InitFromJSONStringMacro.self
]
